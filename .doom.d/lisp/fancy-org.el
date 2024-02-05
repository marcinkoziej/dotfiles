;; Configuration for org mode loaded by config.el


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!


;;; ORG MODE
;;;
;;;
;;;  reference mark ※

(defun mk/prettify-symbols-setup ()
  "Beautify keywords"
  (setq prettify-symbols-alist
        (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
                '(; Greek symbols
                  ("lambda" . ?λ)
                  ("psi"    . ?ψ)
                                        ; Org headers
                  ("#+title:"  . "")
                  ("#+author:" . "")
                                        ; Checkboxes
                  ("[ ]" . "")
                  ("[X]" . "󰱒") ;;"󰄵"
                  ("[-]" . "󰄗")
                                        ; Blocks
                  ("#+begin_src"   . "※") ; 
                  ("#+end_src"     . "※") ; 
                  ("#+begin_QUOTE" . "‟")
                  ("#+end_QUOTE" . "”")
                  ("#+begin_verse" . "⁂")
                  ("#+end_verse" . "⁑")

                                        ; Drawers
                                        ;    ⚙️
                  (":properties:" . "")
                                        ; Agenda scheduling
                                        ; Agenda tags  
                  ;;(":@thesis:"    . "📝")
                  ("#+filetags:"  . "🏷️")
                  )))
  (prettify-symbols-mode))

(setq org-directory "~/Documents/org/")

(use-package! org-fancy-priorities
  :config
  (setq org-fancy-priorities-list '("🚨" "🔥" "🦥")
        org-priority-faces
        '((65 :foreground "#e45649")
          (66 :foreground "#e3a349")
          (67 :foreground "#d3d3d3"))
        org-priority-default ?C)
  )

;; some times colors
;; (height was 2.0 in here, not sure why)

(defface pastelinpurple '((t (:inherit org-todo :height 1.0 :foreground "#957DAD"))) "Face for todo")
(defface pastelgreen '((t (:inherit org-todo :height 1.0 :foreground "#B0EB93"))) "Face for WIP")
(defface pastelpistachio '((t (:inherit org-todo :height 1.0 :foreground "#B3E3DA"))) "Face for DONE")
(defface pastelred '((t (:inherit org-todo :height 1.0 :foreground "#F98284"))) "Face for tags")
(defface pastelpink '((t (:inherit org-todo :height 1.0 :foreground "#FEAAE4"))) "Face for Date")
(defface incyan '((t (:inherit org-todo :height 1.0 :foreground "#00b3b3"))) "Face for Code")
(defface incobolt '((t (:inherit org-todo :height 1.0 :foreground "#0099cc"))) "Face for Verbatim")
(defface inyellow '((t (:inherit org-todo :height 1.0 :foreground "#fff7a0"))) "Face ")
(defface inpurple '((t (:inherit org-todo :height 1.0 :foreground "#bc8dff"))) "Face  Files")
(defface inpurple-note '((t (:inherit org-todo :height 1.0 :foreground "#8977c9"))) "Face for NOTE")
(defface inpurple-note-early '((t (:inherit org-todo :height 1.0 :foreground "#3c4059"))) "Face")

(use-package! org
  :hook ;; this :hook will add -hook to a hook variable
  (org-mode . mk/prettify-symbols-setup)
  (org-mode . org-fancy-priorities-mode)
  (org-agenda-mode . mk/prettify-symbols-setup)

  ;;(setq org-element-use-cache nil) ;; is this needed? or was i trying to fix something?

  :config

  ;; sizes and font changes

  (dolist (face '((org-level-1 . 1.3)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.05)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil  :weight 'bold :height (cdr face)))

  (setq org-agenda-current-time-string "ᐊ――――― now――――――――")
  (custom-set-faces
   '(org-agenda-current-time ((t ( :inherit 'doom-modeline-evil-normal-state  :height 1.09 ))))
   )

  ;; various settings
  (setq org-ellipsis "  ") ;;▾
  (setq! org-startup-with-inline-images 't)
  (setq org-hide-emphasis-markers t)
  (setq org-blank-before-new-entry '((heading . t) (plain-list-item . auto)))
  (setq org-agenda-start-on-weekday nil)
  (setq org-agenda-start-day "-0d"
        org-agenda-span 8)

  (setq org-habit-graph-column 100
        +org-habit-graph-padding 12)

  (setq org-agenda-start-with-log-mode t
        org-deadline-warning-days 8
        org-log-done 'time
        org-agenda-breadcrumbs-separator " ❱ "
        org-log-into-drawer t)


  (setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/Documents/org/todo.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("n" "Notes" entry (file+datetree "~/Documents/org/notes.org")
         "* %?\nDate %U\n  %i\n  %a")
        ("j" "Job" entry (id "tasks")
         "* TODO %? %^g\nProblem: \nSubtasks: \n- [ ] ")
        ))


  (setq org-todo-keywords
        '((sequence
           "TODO(t)" ; A task that needs doing & is ready to do
           "NEXT(n)" ; Task is in progress
           "ACTIVE(a)"
           "BLOCK(b)"
           "|"
           "DONE(d)")

          (sequence
           "IDEA(i)"
           "GOAL(g)"
           "REVIEW(v)"
           "DOING(p)"
           "WAIT(w)" ; Something external is holding up this task
           "HOLD(h)"
           "|"
           "DONE(c)"
           "DROP(X@/!)")

          (sequence
           "SOMEDAY(m)")
          )

        org-todo-keyword-faces
        '(("IDEA"     . pastelpistachio)
          ("GOAL"     . pastelgreen)
          ("REVIEW"   . pastelgreen)
          ("DOING"    . +org-todo-active)
          ("WAIT"     . pastelpink)
          ("HOLD"     . +org-todo-onhold)
          ("BLOCK"    . +org-todo-onhold)
          ("NEXT"     . pastelgreen) ;;XXX temporary idea/ define a new face
          ("WAITING"  . +org-todo-onhold)
          ("DROP" . +org-todo-cancel)
          ("SOMEDAY"  . pastetlpink)
          ("DONE"     . org-done)
          ("ACTIVE"   . +org-todo-active)
          ("DROP"     . +org-todo-cancel)
          ))

  (setq org-agenda-custom-commands
        '(
          ("a" "Agenda"
           ((agenda "")
            (alltodo "" ((org-agenda-files
                           '(
                             "~/Documents/org/todo.org"
                             "~/Documents/org/notes.org")
                           )
                          (org-agenda-sorting-strategy '(priority-down))
                         ))
            (tags-todo "+wemove")
            ;; (tags-todo "+estratos")
            (tags-todo "+breganor")
            )
           )
          ("w" . "TODO+client work")
          ("ww" tags-todo "+wemove")
          ;; ("we" tags-todo "+estratos")
          ("wb" tags-todo "+breganor")
          ))

  ;;           (tags "garden" ((org-agenda-sorting-strategy '(priority-up)))))

  (require 'org-habit)
  (require 'org-checklist)
  (add-to-list 'org-modules 'org-habit)
  (add-to-list 'org-modules 'org-checklist)


  ;; (setq org-tag-alist
  ;;     '((:startgroup)      ;; Put mutually exclusive tags here
  ;;       ("urgent" . ?u)
  ;;       ("nice2have" . ?n)
  ;;       (:endgroup)
  ;;       ("tooling" . ?t)
  ;;       ("health" . ?h)
  ;;       ("work" . ?w)
  ;;       ("learn" . ?l)
  ;;       ("planning" . ?p)
  ;;       ("idea" . ?i)))

  ;; (setq org-tag-faces
  ;;       '(
  ;;         ("urgent" . (:foreground "GoldenRod" :weight bold))
  ;;         )
  ;;       )

)

;; XXX not sure what this is?
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\([-]\\) "
;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;;;
;;; The `display` text property is used to specify how text should be visually
;;; displayed, beyond its actual contents. For example, it can be used to
;;; display images, icons, or modify text appearance. By adding `display` to
;;; `font-lock-extra-managed-props`, you enable font-lock to handle and syntax
;;; highlight text with the `display` property applied.

(add-to-list 'font-lock-extra-managed-props 'display)

(defun mk/org-agenda-show-svg ()
  "Workaround for Org Agenda which does not use font face mode or something"
  (svg-tag-mode t)
    (let* ((case-fold-search nil)
           (keywords (mapcar #'svg-tag--build-keywords svg-tag--active-tags))
           (keyword (car keywords)))
      (while keyword
        (save-excursion
          (while (re-search-forward (nth 0 keyword) nil t)
            (overlay-put (make-overlay
                          (match-beginning 0) (match-end 0))
                         'display  (nth 3 (eval (nth 2 keyword)))) ))
        (pop keywords)
        (setq keyword (car keywords)))))

(use-package! svg-tag-mode
  :after org
  :config

  :init


  (let* ((date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
         (time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
         (day-re "[A-Za-zśą]\\{3\\}")
         (day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re)))

  (setq svg-tag-tags
        `(

                       ;; Active date (with or without day name, with or without time)
                       (,(format "\\(<%s>\\)" date-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1 :end -1 :margin 0))))

                       ;; Datetime glued together (hence the crop)
                       (,(format "\\(<%s \\)%s>" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))

                       (,(format "<%s \\(%s>\\)" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

                       ;; Inactive date  (with or without day name, with or without time)
                       (,(format "\\(\\[%s\\]\\)" date-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))

                       (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1
                                         :inverse nil :crop-right t
                                         :margin 0 :face 'org-date))))

                       (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :end -1
                                         :inverse t :crop-left t
                                         :margin 0 :face 'org-date))))

                       ;; Find TODO headings. checks if 2 letters are capitalized, to not match Sentences starting with a capitel letter
                       ("^[*]+ \\([A-Z][A-Z]+\\) " . ((lambda (tag)
                                                  (svg-tag-make tag :face
                                                                (or (cdr (assoc tag org-todo-keyword-faces)) 'org-todo)
                                                                :inverse t :margin 0
                                                                )
                                                  )))

                       ;; In agenda views, these TODO tags get show after Scheduled (or Sched  1x: or similar..)
                       ("Sched....: +\\([A-Z][A-Z]+\\)" . ((lambda (tag)
                                                  (svg-tag-make tag :face
                                                                (or (cdr (assoc tag org-todo-keyword-faces)) 'org-todo)
                                                                :inverse t :margin 0
                                                                )
                                                  )))

                       ;; ("PROJ" . ((lambda (tag)
                       ;;              (svg-tag-make tag :face 'org-todo :inverse t :margin 0))))
                       ;; ("TODO" . ((lambda (tag)
                       ;;              (svg-tag-make tag :face 'org-todo :inverse t :margin 0))))
                       ;; ("GOAL" . ((lambda (tag)
                       ;;              (svg-tag-make tag :face 'org-todo :inverse t :margin 0))))

                       ;; ("DONE" . ((lambda (tag)
                       ;;              (svg-tag-make tag :face 'org-done :inverse t :margin 0))))
                       ;; ("CANC" . ((lambda (tag)
                       ;;                  (svg-tag-make "CANC" :face 'error :inverse t :margin 0))))
                       ;; ("ACTIVE" . ((lambda (tag)
                       ;;                (svg-tag-make tag :face '+org-todo-active :inverse t :margin 0))))
                       ;; ("PROG" . ((lambda (tag)
                       ;;                (svg-tag-make tag :face '+org-todo-active :inverse t :margin 0))))
                       ;; ("REVIEW" . ((lambda (tag)
                       ;;                (svg-tag-make tag :face 'font-lock-keyword-face
                       ;;                              :inverse t :margin 0))))
                       ;; ("IDEA" . ((lambda (tag)
                       ;;                (svg-tag-make tag :face '+org-todo-active :inverse t :margin 0))))
                       ;; ("NEXT" . ((lambda (tag)
                       ;;              (svg-tag-make tag :face 'font-lock-keyword-face :inverse t :margin 0))))

                       ;; ("WAIT" . ((lambda (tag)
                       ;;              (svg-tag-make tag :face 'org-warning :inverse t :margin 0))))
                       ;; ("HOLD" . ((lambda (tag)
                       ;;              (svg-tag-make tag :face 'org-warning :inverse t :margin 0))))



                       ;;; #+filetags: etc
                       ("\\(#\\+[A-Za-z0-9#_]+:\\)" . ((lambda (tag)
                                                     (svg-tag-make tag
                                                             :face 'svg-lib-button-press-face :beg 1
                                                             :end -1 :inverse t))))

                       ("\\(:[a-zA-Z#0-9:]+:\\)" . ((lambda (tag)
                                                     (svg-tag-make tag
                                                             :face 'svg-lib-button-press-face :beg 1
                                                             :end -1 :inverse t))))

                       ("\\(:[a-zA-Z]+\\)\|[a-zA-Z#0-9]+:" . ((lambda (tag)
                                                         (svg-tag-make tag :beg 1 :inverse t
                                                               :face 'svg-lib-button-press-face
                                                               :margin 0 :crop-right t))))
                       (":[a-zA-Z]+\\(:[a-zA-Z#0-9]+:\\)" . ((lambda (tag)
                                                             (svg-tag-make tag :beg 1 :end -1
                                                               :face 'svg-lib-button-press-face
                                                                           :margin 0
                                                                           crop-left t))))
                       ;; Task priority - handled by org-fancy-priorities-mode
           ;;            ("\\[#[A-Z]\\]" . ( (lambda (tag)
             ;;                                (svg-tag-make tag :face 'org-priority :inverse t
               ;;                                            :beg 2 :end -1 :margin 0))))


                       ;; ("\\([:]\\{1\\}\\W?\\(?:FIXME\\|Fixme\\)|.*\\)" . ((lambda (tag) (svg-tag-make tag
                       ;;                                                                           :face 'incyan
                       ;;                                                                           :inverse t
                       ;;                                                                           :crop-left t
                       ;;                                                                           :beg 7))))

                       ;; ("\\([:]\\{1\\}\\W?\\(?:FIX\\|Fix\\)|.*\\)" . ((lambda (tag) (svg-tag-make tag
                       ;;                                                                       :face 'incyan
                       ;;                                                                       :inverse t
                       ;;                                                                       :crop-left t
                       ;;                                                                       :beg 5))))

                       ;; ("\\([:]\\{1\\}\\W?\\(?:HACK\\|PERF\\|MARK\\|Hack\\)*|.*\\)" . ((lambda (tag) (svg-tag-make tag
                       ;;                                                                                        :face 'incyan
                       ;;                                                                                        :inverse t
                       ;;                                                                                        :crop-left t
                       ;;                                                                                        :beg 6))))
                       ;; ("\\([:]\\{1\\}\\W?\\(?:NOTE\\|Note\\)*|.*\\)" . ((lambda (tag) (svg-tag-make tag
                       ;;                                                                          :face 'incyan
                       ;;                                                                          :inverse t
                       ;;                                                                          :crop-left t
                       ;;                                                                          :beg 6))))


                       ;; ("\\([:]\\{1\\}\\W?\\(?:Note\\|NOTE\\)*|\\)" . ((lambda (tag) (svg-tag-make tag
                       ;;                                                                        :face 'incyan
                       ;;                                                                        :inverse nil
                       ;;                                                                        :margin 0
                       ;;                                                                        :crop-right t
                       ;;                                                                        :beg 1
                       ;;                                                                        :end -1))))


                       ;; ("\\([:]\\{1\\}\\W?\\(?:HACK\\|Hack\\|PERF\\|FIXME\\|Fixme\\|FIX\\|Fix\\|MARK\\)*|\\)" . ((lambda (tag) (svg-tag-make tag
                       ;;                                                                                                                  :face 'incyan
                       ;;                                                                                                                  :inverse nil
                       ;;                                                                                                                  :margin 0
                       ;;                                                                                                                  :crop-right t
                       ;;                                                                                                                  :beg 1
                       ;;                                                                                                                  :end -1))))

                       (":TODO:" . ((lambda (tag) (svg-tag-make "TODO" :inverse t :face 'pastelinpurple))))
                       ;; (":PROPERTIES:" . ((lambda (tag) (svg-tag-make "PROPERTIES" :inverse t :face 'inpurple))))
                       ("SCHEDULED:" . ((lambda (tag) (svg-tag-make "SCHEDULED" :inverse t :face 'incobolt))))
                       ("DEADLINE:" . ((lambda (tag) (svg-tag-make "DEADLINE" :inverse t :face 'incobolt))))
                       ;; ("#+author:" . ((lambda (tag) (svg-tag-make "AUTHOR" :inverse t :face 'incobolt))))
                       ;; ("+date:" . ((lambda (tag) (svg-tag-make "DATE" :inverse t :face 'incobolt))))
                       ;; ("+OPTIONS:" . ((lambda (tag) (svg-tag-make "OPTIONS" :face 'incobolt))))
                       ;; ("#+STARTUP" . ((lambda (tag) (svg-tag-make "STARTUP" :inverse t :face 'incobolt))))
                       ;;  ("+RESULTS:" . ((lambda (tag) (svg-tag-make "RESULTS" :inverse t :face 'cobolt))))
                       ;; ("+CAPTION:" . ((lambda (tag) (svg-tag-make "CAPTION" :inverse t :face 'incyan))))
                       ;; ("+NAME:" . ((lambda (tag) (svg-tag-make "NAME" :inverse t :face 'incyan))))
                       (":ID:" . ((lambda (tag) (svg-tag-make "ID" :face 'inpurple))))
                       (":END:" . ((lambda (tag) (svg-tag-make "END" :inverse t :face 'inpurple))))

                       ;; Active date (with or without day name, with or without time)
                       ;; <2023-04-03 Sun 17:45>
                       (,(format "\\(<%s>\\)" date-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1 :end -1 :margin 0))))
                       (,(format "\\(<%s \\)%s>" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1 :inverse t :crop-right t :margin 0 :face 'org-date))))
                       (,(format "<%s \\(%s>\\)" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :end -1 :inverse nil :crop-left t :margin 0 :face 'org-date))))



                       ;; Inactive date  (with or without day name, with or without time)
                       ;; [2023-04-03 Sun 17:45]
                       (,(format "\\(\\[%s\\]\\)" date-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
                       (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-agenda-date))))
                       (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
                        ((lambda (tag)
                           (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-agenda-date))))

                       )))

  :hook
  (org-mode . svg-tag-mode)
  (org-agenda-finalize . mk/org-agenda-show-svg)
)


;; TODO for variable font in org mode. Might be nicer to write and read indeed
;; (custom-theme-set-faces
;;  'user
;;  '(org-block ((t (:inherit fixed-pitch))))
;;  '(org-code ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
;;  '(org-link ((t ( :underline t))))
;;  '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-property-value ((t (:inherit fixed-pitch))) t)
;;  '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-table ((t (:inherit fixed-pitch ))))
;;  '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;;  '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
