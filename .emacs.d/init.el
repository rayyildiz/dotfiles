
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize))


(custom-set-variables
 '(package-selected-packages
   (quote
    (jsx-mode flycheck web-mode dockerfile-mode go magit git projectile shell-here go-autocomplete exec-path-from-shell neotree ensime company-go go-eldoc go-mode))))
(custom-set-faces
 )


(setq ns-right-alternate-modifier nil)

(setq company-idle-delay t)

(global-set-key (kbd "C-c M-n") 'company-complete)
(global-set-key (kbd "C-c C-n") 'company-complete)

(defun custom-go-mode-hook()
  (local-set-key (kbd "C-c m") 'gofmt)
  (local-set-key (kbd "M-.") 'godef-jump)
  (set (make -local-variable 'company-backends) '(comapny-go))
  )

(add-hook 'go-mode-hook 'custom-go-mode-hook)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook 'company-mode)

(setenv "GOPATH" "/Users/rayyildiz/workspace/gopath")
(add-to-list 'exec-path "/Users/rayyildiz/workspace/gopath/bin")
(add-hook 'before-save-hook 'gofmt-before-save)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

;; (when window-system (set-exec-path-from-shell-PATH))

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))

(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Scala
(add-to-list 'exec-path "/usr/local/bin")

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

