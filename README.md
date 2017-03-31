# yas-edit

Convenience functions for [yassnippet](https://github.com/joaotavora/yasnippet) to all you to [define snippets as you go](https://facetframer.com/dayg).

Analogous to [zshnip](https://github.com/facetframer/zshnip)

# Installation

Make sure you has [yassnippet](https://github.com/joaotavora/yasnippet) installed.

```
git clone https://github.com/facetframer/yas-edit ~/yas-edit
```

Add the following to you `init.el`


```
(add-to-list 'load-path "~/yas-edit")
(require 'yas-edit)
```

Define some keybindings that you like

```
(global-set-key (kbd "M-e") 'yas-edit)
(global-set-key (kbd "M-j") 'yas-expand-or-edit)

```
