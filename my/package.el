;; Dependent on packages
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)
(if (not (package-installed-p 'use-package))
    (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(package-install 'diminish)
(if (not (featurep 'diminish))
    (require 'diminish))
(if (not (featurep 'bind-key))
    (require 'bind-key))

(provide 'my-package)
