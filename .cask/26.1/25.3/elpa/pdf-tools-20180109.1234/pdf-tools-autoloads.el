;;; pdf-tools-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "pdf-annot" "pdf-annot.el" (23173 59102 207206
;;;;;;  606000))
;;; Generated autoloads from pdf-annot.el

(autoload 'pdf-annot-minor-mode "pdf-annot" "\
Support for PDF Annotations.

\\{pdf-annot-minor-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "pdf-history" "pdf-history.el" (23173 59102
;;;;;;  191206 688000))
;;; Generated autoloads from pdf-history.el

(autoload 'pdf-history-minor-mode "pdf-history" "\
Keep a history of previously visited pages.

This is a simple stack-based history.  Turning the page or
following a link pushes the left-behind page on the stack, which
may be navigated with the following keys.

\\{pdf-history-minor-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "pdf-isearch" "pdf-isearch.el" (23173 59102
;;;;;;  466205 281000))
;;; Generated autoloads from pdf-isearch.el

(autoload 'pdf-isearch-minor-mode "pdf-isearch" "\
Isearch mode for PDF buffer.

When this mode is enabled \\[isearch-forward], among other keys,
starts an incremental search in this PDF document.  Since this mode
uses external programs to highlight found matches via
image-processing, proceeding to the next match may be slow.

Therefore two isearch behaviours have been defined: Normal isearch and
batch mode.  The later one is a minor mode
\(`pdf-isearch-batch-mode'), which when activated inhibits isearch
from stopping at and highlighting every single match, but rather
display them batch-wise.  Here a batch means a number of matches
currently visible in the selected window.

The kind of highlighting is determined by three faces
`pdf-isearch-match' (for the current match), `pdf-isearch-lazy'
\(for all other matches) and `pdf-isearch-batch' (when in batch
mode), which see.

Colors may also be influenced by the minor-mode
`pdf-view-dark-minor-mode'.  If this is minor mode enabled, each face's
dark colors, are used (see e.g. `frame-background-mode'), instead
of the light ones.

\\{pdf-isearch-minor-mode-map}
While in `isearch-mode' the following keys are available. Note
that not every isearch command work as expected.

\\{pdf-isearch-active-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "pdf-links" "pdf-links.el" (23173 59102 242206
;;;;;;  428000))
;;; Generated autoloads from pdf-links.el

(autoload 'pdf-links-minor-mode "pdf-links" "\
Handle links in PDF documents.\\<pdf-links-minor-mode-map>

If this mode is enabled, most links in the document may be
activated by clicking on them or by pressing \\[pdf-links-action-perform] and selecting
one of the displayed keys, or by using isearch limited to
links via \\[pdf-links-isearch-link].

\\{pdf-links-minor-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'pdf-links-action-perform "pdf-links" "\
Follow LINK, depending on its type.

This may turn to another page, switch to another PDF buffer or
invoke `pdf-links-browse-uri-function'.

Interactively, link is read via `pdf-links-read-link-action'.
This function displays characters around the links in the current
page and starts reading characters (ignoring case).  After a
sufficient number of characters have been read, the corresponding
link's link is invoked.  Additionally, SPC may be used to
scroll the current page.

\(fn LINK)" t nil)

;;;***

;;;### (autoloads nil "pdf-misc" "pdf-misc.el" (23173 59102 197206
;;;;;;  658000))
;;; Generated autoloads from pdf-misc.el

(autoload 'pdf-misc-minor-mode "pdf-misc" "\
FIXME:  Not documented.

\(fn &optional ARG)" t nil)

(autoload 'pdf-misc-size-indication-minor-mode "pdf-misc" "\
Provide a working size indication in the mode-line.

\(fn &optional ARG)" t nil)

(autoload 'pdf-misc-menu-bar-minor-mode "pdf-misc" "\
Display a PDF Tools menu in the menu-bar.

\(fn &optional ARG)" t nil)

(autoload 'pdf-misc-context-menu-minor-mode "pdf-misc" "\
Provide a right-click context menu in PDF buffers.

\\{pdf-misc-context-menu-minor-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "pdf-occur" "pdf-occur.el" (23173 59102 225206
;;;;;;  514000))
;;; Generated autoloads from pdf-occur.el

(autoload 'pdf-occur "pdf-occur" "\
List lines matching STRING or PCRE.

Interactively search for a regexp. Unless a prefix arg was given,
in which case this functions performs a string search.

If `pdf-occur-prefer-string-search' is non-nil, the meaning of
the prefix-arg is inverted.

\(fn STRING &optional REGEXP-P)" t nil)

(autoload 'pdf-occur-multi-command "pdf-occur" "\
Perform `pdf-occur' on multiple buffer.

For a programmatic search of multiple documents see
`pdf-occur-search'.

\(fn)" t nil)

(defvar pdf-occur-global-minor-mode nil "\
Non-nil if Pdf-Occur-Global minor mode is enabled.
See the `pdf-occur-global-minor-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `pdf-occur-global-minor-mode'.")

(custom-autoload 'pdf-occur-global-minor-mode "pdf-occur" nil)

(autoload 'pdf-occur-global-minor-mode "pdf-occur" "\
Enable integration of Pdf Occur with other modes.

This global minor mode enables (or disables)
`pdf-occur-ibuffer-minor-mode' and `pdf-occur-dired-minor-mode'
in all current and future ibuffer/dired buffer.

\(fn &optional ARG)" t nil)

(autoload 'pdf-occur-ibuffer-minor-mode "pdf-occur" "\
Hack into ibuffer's do-occur binding.

This mode remaps `ibuffer-do-occur' to
`pdf-occur-ibuffer-do-occur', which will start the PDF Tools
version of `occur', if all marked buffer's are in `pdf-view-mode'
and otherwise fallback to `ibuffer-do-occur'.

\(fn &optional ARG)" t nil)

(autoload 'pdf-occur-dired-minor-mode "pdf-occur" "\
Hack into dired's `dired-do-search' binding.

This mode remaps `dired-do-search' to
`pdf-occur-dired-do-search', which will start the PDF Tools
version of `occur', if all marked buffer's are in `pdf-view-mode'
and otherwise fallback to `dired-do-search'.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "pdf-outline" "pdf-outline.el" (23173 59102
;;;;;;  459205 316000))
;;; Generated autoloads from pdf-outline.el

(autoload 'pdf-outline-minor-mode "pdf-outline" "\
Display an outline of a PDF document.

This provides a PDF's outline on the menu bar via imenu.
Additionally the same outline may be viewed in a designated
buffer.

\\{pdf-outline-minor-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'pdf-outline "pdf-outline" "\
Display an PDF outline of BUFFER.

BUFFER defaults to the current buffer.  Select the outline
buffer, unless NO-SELECT-WINDOW-P is non-nil.

\(fn &optional BUFFER NO-SELECT-WINDOW-P)" t nil)

(autoload 'pdf-outline-imenu-enable "pdf-outline" "\
Enable imenu in the current PDF buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "pdf-sync" "pdf-sync.el" (23173 59102 248206
;;;;;;  397000))
;;; Generated autoloads from pdf-sync.el

(autoload 'pdf-sync-minor-mode "pdf-sync" "\
Correlate a PDF position with the TeX file.
\\<pdf-sync-minor-mode-map>
This works via SyncTeX, which means the TeX sources need to have
been compiled with `--synctex=1'.  In AUCTeX this can be done by
setting `TeX-source-correlate-method' to 'synctex (before AUCTeX
is loaded) and enabling `TeX-source-correlate-mode'.

Then \\[pdf-sync-backward-search-mouse] in the PDF buffer will open the
corresponding TeX location.

If AUCTeX is your preferred tex-mode, this library arranges to
bind `pdf-sync-forward-display-pdf-key' (the default is `C-c C-g')
to `pdf-sync-forward-search' in `TeX-source-correlate-map'.  This
function displays the PDF page corresponding to the current
position in the TeX buffer.  This function only works together
with AUCTeX.

\(fn &optional ARG)" t nil)

(define-obsolete-variable-alias 'pdf-sync-tex-display-pdf-key 'pdf-sync-forward-display-pdf-key nil)

(define-obsolete-variable-alias 'pdf-sync-goto-tex-hook 'pdf-sync-backward-hook nil)

(define-obsolete-variable-alias 'pdf-sync-display-pdf-hook 'pdf-sync-forward-hook nil)

(define-obsolete-variable-alias 'pdf-sync-display-pdf-action 'pdf-sync-forward-display-action nil)

;;;***

;;;### (autoloads nil "pdf-tools" "pdf-tools.el" (23173 59102 260206
;;;;;;  335000))
;;; Generated autoloads from pdf-tools.el

(defvar pdf-tools-handle-upgrades t "\
Whether PDF Tools should handle upgrading itself.")

(custom-autoload 'pdf-tools-handle-upgrades "pdf-tools" t)

(autoload 'pdf-tools-install "pdf-tools" "\
Install PDF-Tools in all current and future PDF buffers.

If the `pdf-info-epdfinfo-program' is not running or does not
appear to be working, attempt to rebuild it.  If this build
succeeded, continue with the activation of the package.
Otherwise fail silently, i.e. no error is signaled.

Build the program (if necessary) without asking first, if
NO-QUERY-P is non-nil.

Don't attempt to install system packages, if SKIP-DEPENDENCIES-P
is non-nil.

Do not signal an error in case the build failed, if NO-ERROR-P is
non-nil.

Attempt to install system packages (even if it is deemed
unnecessary), if FORCE-DEPENDENCIES-P is non-nil.

Note that SKIP-DEPENDENCIES-P and FORCE-DEPENDENCIES-P are
mutually exclusive.

Note further, that you can influence the installation directory
by setting `pdf-info-epdfinfo-program' to an appropriate
value (e.g. ~/bin/epdfinfo) before calling this function.

See `pdf-view-mode' and `pdf-tools-enabled-modes'.

\(fn &optional NO-QUERY-P SKIP-DEPENDENCIES-P NO-ERROR-P FORCE-DEPENDENCIES-P)" t nil)

(autoload 'pdf-tools-enable-minor-modes "pdf-tools" "\
Enable MODES in the current buffer.

MODES defaults to `pdf-tools-enabled-modes'.

\(fn &optional MODES)" t nil)

(autoload 'pdf-tools-help "pdf-tools" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "pdf-view" "pdf-view.el" (23173 59102 254206
;;;;;;  366000))
;;; Generated autoloads from pdf-view.el

(autoload 'pdf-view-bookmark-jump-handler "pdf-view" "\
The bookmark handler-function interface for bookmark BMK.

See also `pdf-view-bookmark-make-record'.

\(fn BMK)" nil nil)

;;;***

;;;### (autoloads nil "pdf-virtual" "pdf-virtual.el" (23173 59102
;;;;;;  236206 458000))
;;; Generated autoloads from pdf-virtual.el

(autoload 'pdf-virtual-edit-mode "pdf-virtual" "\
Major mode when editing a virtual PDF buffer.

\(fn)" t nil)

(autoload 'pdf-virtual-view-mode "pdf-virtual" "\
Major mode in virtual PDF buffers.

\(fn)" t nil)

(defvar pdf-virtual-global-minor-mode nil "\
Non-nil if Pdf-Virtual-Global minor mode is enabled.
See the `pdf-virtual-global-minor-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `pdf-virtual-global-minor-mode'.")

(custom-autoload 'pdf-virtual-global-minor-mode "pdf-virtual" nil)

(autoload 'pdf-virtual-global-minor-mode "pdf-virtual" "\
Enable recognition and handling of VPDF files.

\(fn &optional ARG)" t nil)

(autoload 'pdf-virtual-buffer-create "pdf-virtual" "\


\(fn &optional FILENAMES BUFFER-NAME DISPLAY-P)" t nil)

;;;***

;;;### (autoloads nil nil ("pdf-cache.el" "pdf-dev.el" "pdf-info.el"
;;;;;;  "pdf-tools-pkg.el" "pdf-util.el") (23173 59102 452205 352000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; pdf-tools-autoloads.el ends here
