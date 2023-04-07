dim Url
Url = ""
dim File

set wshshell = CreateObject("wscript.shell")
Set fso = CreateObject("Scripting.FileSystemObject")

Set File = fso.GetFile("./videoId/id.txt")  ' Use "Set" to assign object reference

do
  If DateDiff("s", File.DateLastModified, Now()) < 1 then
    Url = "https://youtube.com/watch?v=" & fso.OpenTextFile(File.Path, 1).ReadLine()
    wshshell.run Url 
  End If
  WScript.Sleep 1000
loop