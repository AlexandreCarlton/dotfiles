;;; package --- Summary

;;; Commentary:
;;; Look at http://github.com/mcandre/dotfiles/blob/master/.emacs
;;; Has lazy-loading so if we start it up it only loads the necessary plugins

(require 'package)

;;; Code:

; Package repositories
(add-to-list 'package-archives
  '("gnu" . "http://elpa.gnu.org/packages/") t) ; core repository
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

; Get rid of blinking cursor
(blink-cursor-mode 0)

; Files that is not empty should end in newline character.
(setq require-final-newline t)

; No tabs; only spaces
(setq-default indent-tabs-mode nil)

; Keep backup files out of the way (in a directory .~)
(setq backup-directory-alist '(("." . ".~")))

; Line numbers
(global-linum-mode t)

; ; Enable Vim Keybindings
; (evil-mode 1)
; (key-chord-mode 1)
; ; Use key-chord for easy mappings.
; (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
; (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)

; Colour
(global-font-lock-mode t) ; Colour coding.
; (load-theme 'solarized-dark)


; Set all the things to UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


; Customise ModeLine (status bar)
; (powerline-default-theme)

; Syntax checking
(add-hook 'after-init-hook #'global-flycheck-mode)

; Auto completion
; (autoload 'company-mode "company" nil t)
(add-hook 'after-init-hook 'global-company-mode)
;(add-to-list 'company-backends 'company-ghc)

; Haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

; Python Environment
; Elpy uses autoload, so add-hook not necessary.
; (add-hook 'python-mode-hook #'elpy-enable)
(elpy-enable)

; R, Rnw, etc.
(require 'ess-site) ; use require?
; (add-hook 'R-mode-hook
;           (lambda ()
;             (load "ess-site")))


(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("bd115791a5ac6058164193164fd1245ac9dc97207783eae036f0bfc9ad9670e0" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
