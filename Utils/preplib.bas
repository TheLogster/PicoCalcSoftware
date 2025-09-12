Option explicit

Drive "b:"

Dim integer counter
Dim integer entries = 2
Dim string Source(entries)
Dim f$
Dim t$

Source(0) = "utils.bas"
Source(1) = "help2.bas"

Print "Creating libsrc.bas"
Print


Open "libsrc.bas" For output As #1

For counter = 0 To entries - 1
  f$ = Source(counter)

  Print "Copying "; f$

  Open f$ For input As #2
    Do While Not Eof(#2)
      Line Input #2, t$
      Print #1, t$
    Loop
  Close #2
Next counter

Close #1

Print "All done"
