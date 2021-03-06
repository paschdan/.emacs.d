(blink-cursor-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq mouse-highlight nil)
(setq scroll-conservatively 0)
(setq column-number-mode t)
(setq-default cursor-in-non-selected-windows nil)
(setq x-underline-at-descent-line t)
(setq x-stretch-cursor t)

;; copy/pasted from spacemacs chinese layer
(defun private/set-monospaced-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" english english-size))
  (set-frame-font english)
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese :size chinese-size))))

(private/set-monospaced-font "Iosevka" "PingFang SC" 14 14)

(use-package solarized-theme
  :init (progn
          (setq solarized-use-variable-pitch nil)
          (setq solarized-scale-org-headlines nil)
          (load-theme 'solarized-dark t nil)))

(use-package delight
  :defer t)

(use-package smart-mode-line
  :init
  (sml/setup))

(use-package nyan-mode
  :commands 'nyan-mode)

(use-package whitespace-mode
  :ensure nil
  :init
  (progn
    (setq whitespace-style
          '(face trailing indentation empty space-after-tab space-before-tab tab-mark))
    (global-whitespace-mode)))

(use-package popwin
  :after windows
  :demand t
  :config
  (progn
      (setq popwin:special-display-config nil)

      (push '("*Help*"                  :dedicated t :position bottom :stick t :noselect t   :height 0.4) popwin:special-display-config)
      (push '("*compilation*"           :dedicated t :position bottom :stick t :noselect t   :height 0.4) popwin:special-display-config)
      (push '("*Shell Command Output*"  :dedicated t :position bottom :stick t :noselect nil            ) popwin:special-display-config)
      (push '("*Pp Macroexpand Output*" :dedicated t :position bottom :stick t :noselect nil            ) popwin:special-display-config)
      (push '("*Async Shell Command*"   :dedicated t :position bottom :stick t :noselect nil            ) popwin:special-display-config)
      (push '("*undo-tree*"             :dedicated t :position right  :stick t :noselect nil :width   60) popwin:special-display-config)
      (push '("*undo-tree Diff*"        :dedicated t :position bottom :stick t :noselect nil :height 0.3) popwin:special-display-config)
      (push '("*ert*"                   :dedicated t :position bottom :stick t :noselect nil            ) popwin:special-display-config)
      (push '("*grep*"                  :dedicated t :position bottom :stick t :noselect nil            ) popwin:special-display-config)
      (push '("*nosetests*"             :dedicated t :position bottom :stick t :noselect nil            ) popwin:special-display-config)
      (push '("^\*WoMan.+\*$" :regexp t              :position bottom                                   ) popwin:special-display-config)

      (popwin-mode 1))
  :general
  (private/set-leader-keys
   "wpc" 'popwin:close-popup-window
   "wps" 'popwin:stick-popup-window
   "wpl" 'popwin:switch-to-last-buffer
   "wpp" 'popwin:popup-last-buffer))

(use-package hl-todo
  :init
  (add-hook 'prog-mode-hook 'hl-todo-mode))

(use-package zoom-frm
  :config
  (progn
    (defhydra private/zoom-frm-hydra ()
      ("+" zoom-frm-in "Frame zoom in")
      ("=" zoom-frm-in "Frame zoom in")
      ("-" zoom-frm-out "Frame zoom out")
      ("0" zoom-frm-unzoom "Frame unzoom"))

    (defhydra private/zoom-text-hydra ()
      ("+" text-scale-increase "Text zoom in")
      ("=" text-scale-increase "Text zoom in")
      ("-" text-scale-decrease "Text zoom out")
      ("0" (text-scale-set 0) "Text unzoom")))
  :general
  (private/set-leader-keys
   "zf" 'private/zoom-frm-hydra/body
   "zx" 'private/zoom-text-hydra/body))

(use-package centered-window-mode
  :config
  (progn
    (setq cwm-use-vertical-padding t)
    (setq cwm-frame-internal-border 70)))

(use-package highlight-indentation
  :delight
  :defer t
  :general
  (private/set-leader-keys
   "thi" 'highlight-indentation-mode
   "thc" 'highlight-indentation-current-column-mode))

(use-package indent-guide
  :delight
  :defer t
  :general
  (private/set-leader-keys
   "ti" 'indent-guide-mode
   "t TAB" 'indent-guide-global-mode))

(use-package display-line-numbers
  :ensure nil
  :if (>= emacs-major-version 26)
  :init
  (progn
    (setq display-line-numbers-type 'visual)
    (add-hook 'prog-mode-hook 'display-line-numbers-mode))
  :general
  (private/set-leader-keys
   "tn" 'display-line-numbers-mode
   "tN" 'global-display-line-numbers-mode))

(provide 'init-ui)
