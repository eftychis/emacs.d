;;; zones-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "zones" "zones.el" (23012 8918 529809 51000))
;;; Generated autoloads from zones.el

(autoload 'zz-select-region "zones" "\
Select a region from among the current set of zones.
The zones are those in the current `zz-izones-var'.
With no prefix arg, select the previous recorded zone.
With a numeric prefix arg N, select the Nth previous zone.

Note that if the value of `zz-izones-var' is not buffer-local then you
can use this command to cycle among regions in multiple buffers.

\(fn ARG &optional MSGP)" t nil)

(autoload 'zz-narrow "zones" "\
Widen to a previous buffer restriction (narrowing).
The candidates are the zones in the current `zz-izones-var'.

With no prefix arg, widen to the previous narrowing.
With a plain prefix arg (`C-u'), widen completely.
With a zero  prefix arg (`C-0'), widen completely and reset (empty)
 the list of zones for this buffer.
With a numeric prefix arg N, widen abs(N) times (to the abs(N)th
 previous narrowing).  Positive and negative args work the same,
 except that a negative arg also pops entries off the ring: it removes
 the ring entries from the most recent back through the (-)Nth one.

\(fn ARG &optional MSGP)" t nil)

(autoload 'zz-add-zone "zones" "\
Add a zone for the text from START to END to the zones of VARIABLE.
Return the new value of VARIABLE.

This is a destructive operation: The list structure of the variable
value can be modified.

VARIABLE defaults to the value of `zz-izones-var'.
START and END are as for `narrow-to-region'.

With a prefix arg you are prompted for a different variable to use, in
place of the current value of `zz-izones-var'.  The particular prefix
arg determines whether the variable, if unbound, is made buffer-local,
and whether `zz-izones-var' is set to the variable symbol:

  prefix arg          buffer-local   set `zz-izones-var'
  ----------          ------------   -------------------
   Plain `C-u'         yes            yes
   > 0 (e.g. `C-1')    yes            no
   = 0 (e.g. `C-0')    no             yes
   < 0 (e.g. `C--')    no             no

Non-interactively:
* VARIABLE is the optional izones variable to use.
* Non-nil NOT-BUF-LOCAL-P means do not make VARIABLE buffer-local.
* Non-nil SET-VAR-P means set `zz-izones-var' to VARIABLE.
* Non-nil MSGP means echo the region size.

\(fn START END &optional VARIABLE NOT-BUF-LOCAL-P SET-VAR-P MSGP)" t nil)

(autoload 'zz-delete-zone "zones" "\
Delete the zone numbered N from VARIABLE, and renumber those remaining.
Return the new value of VARIABLE.

This is a destructive operation: The list structure of the variable
value can be modified.

You are prompted for the number N.
VARIABLE defaults to the value of `zz-izones-var'.

With a prefix arg you are prompted for a different variable to use, in
place of the current value of `zz-izones-var'.  The
particular prefix arg determines whether the variable, if unbound, is
made buffer-local, and whether `zz-izones-var' is set to the
variable symbol:

  prefix arg          buffer-local   set `zz-izones-var'
  ----------          ------------   -------------------
   Plain `C-u'         yes            yes
   > 0 (e.g. `C-1')    yes            no
   = 0 (e.g. `C-0')    no             yes
   < 0 (e.g. `C--')    no             no

Non-nil optional arg NOMSG means do not display a status message.

\(fn N &optional VARIABLE NOT-BUF-LOCAL-P SET-VAR-P MSGP)" t nil)

(autoload 'zz-narrow-repeat "zones" "\
Cycle to the next buffer restriction (narrowing).
This is a repeatable version of `zz-narrow'.

Note that if the value of `zz-izones-var' is not buffer-local then you
can use this command to cycle among regions in multiple buffers.

\(fn ARG)" t nil)

(autoload 'zz-select-region-repeat "zones" "\
Cycle to the next region.
This is a repeatable version of `zz-select-region'.

\(fn ARG)" t nil)

(autoload 'zz-set-izones-var "zones" "\
Set `zz-izones-var' to VARIABLE, for which you are prompted.
With a prefix arg, make VARIABLE automatically be buffer-local.

\(fn VARIABLE &optional LOCALP)" t nil)

(autoload 'zz-clone-zones "zones" "\
Clone FROM-VARIABLE to TO-VARIABLE.
That is, copy the zones of FROM-VARIABLE to (emptied) TO-VARIABLE.
A non-destructive operation: The value of TO-VARIABLE is a new list,
 with only the zones from FROM-VARIABLE.
Return the value of TO-VARIABLE.

You are prompted for FROM-VARIABLE and TO-VARIABLE.

With a non-negative (>= 0) prefix arg, make TO-VARIABLE buffer-local.
With a non-positive (<= 0) prefix arg, set `zz-izones-var' to the
TO-VARIABLE symbol.  (Zero: do both.)

FROM-VARIABLE defaults to the value of `zz-izones-var'.

Non-interactively: Non-nil MSGP means show a status message.

\(fn FROM-VARIABLE TO-VARIABLE &optional MSGP)" t nil)

(defalias 'zz-clone-and-coalesce-zones 'zz-clone-and-unite-zones)

(autoload 'zz-clone-and-unite-zones "zones" "\
Clone FROM-VARIABLE to TO-VARIABLE, then unite (coalesce) TO-VARIABLE.
That is, use`zz-clone-zones' to fill TO-VARIABLE, then use
`zz-unite-zones' on TO-VARIABLE.

Use this when you do not want to unite the zones of FROM-VARIABLE (for
example, you want to use them as possibly overlapping buffer
narrowings), but you also want to act on the united zones (for
example, to search them).

FROM-VARIABLE defaults to the value of `zz-izones-var'.

Non-interactively: Non-nil MSGP means show a status message.

\(fn FROM-VARIABLE TO-VARIABLE &optional MSGP)" t nil)

(defalias 'zz-coalesce-zones 'zz-unite-zones)

(autoload 'zz-unite-zones "zones" "\
Coalesce (unite) the izones of VARIABLE.
A non-destructive operation: The new value of VARIABLE is a new list.
Return the new value of VARIABLE.

VARIABLE defaults to the value of `zz-izones-var'.
With a prefix arg you are prompted for a different variable to use, in
place of the current value of `zz-izones-var'.  If the prefix arg is
non-negative (>= 0) then make the variable buffer-local.  If the
prefix arg is non-positive (<= 0) then set `zz-izones-var' to that
variable symbol.  (Zero: do both.)

Non-interactively:
* VARIABLE is the optional izones variable to use.
* Non-nil MSGP means show a status message.

\(fn &optional VARIABLE MSGP)" t nil)

(defalias 'zz-add-zone-and-coalesce 'zz-add-zone-and-unite)

(autoload 'zz-add-zone-and-unite "zones" "\
Add an izone from START to END to those of VARIABLE, and coalesce.
Use `zz-add-zone', then apply `zz-unite-zones'.
Return the new value of VARIABLE.

This is a destructive operation: The list structure of the variable
value can be modified.

VARIABLE defaults to the value of `zz-izones-var'.
START and END are as for `narrow-to-region'.

With a prefix arg you are prompted for a different variable to use, in
place of the current value of `zz-izones-var'.  If the prefix arg is
non-negative (>= 0) then make the variable buffer-local.  If the
prefix arg is non-positive (<= 0) then set `zz-izones-var' to that
variable symbol.  (Zero: do both.)

Non-interactively:
* VARIABLE is the optional izones variable to use.
* Non-nil MSGP means echo the size of the added zone.

\(fn START END &optional VARIABLE MSGP)" t nil)

(autoload 'narrow-to-defun "zones" "\
Make text outside current defun invisible.
The visible defun is the one that contains point or follows point.
Optional ARG is ignored.

This is a destructive operation. The list structure of the variable
that is the value of `zz-izones-var' can be modified.

\(fn &optional ARG)" t nil)

(autoload 'narrow-to-page "zones" "\
Make text outside current page invisible.
A numeric arg specifies to move forward or backward by that many pages,
thus showing a page other than the one point was originally in.

This is a destructive operation. The list structure of the variable
that is the value of `zz-izones-var' can be modified.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; zones-autoloads.el ends here
