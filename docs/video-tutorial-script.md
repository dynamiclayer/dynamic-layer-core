# DynamicLayer + Claude Code — Video Tutorial Script

## Video-Übersicht

**Titel-Vorschlag:** "Build your own App without coding — DynamicLayer + Claude Code Setup Guide"
**Geschätzte Länge:** 15–25 Minuten
**Zielgruppe:** Designer ohne Entwickler-Erfahrung

---

## INTRO (Kamera)

**Sprechen:**

> "Hey, in diesem Video zeige ich dir Schritt für Schritt, wie du DynamicLayer zusammen mit Claude Code auf deinem Mac einrichtest — damit du als Designer deine eigene App bauen kannst, ohne eine einzige Zeile Code schreiben zu müssen.
>
> Wir installieren heute alles, was du brauchst. Das klingt nach viel, aber ich gehe jeden Schritt mit dir durch. Am Ende des Videos hast du eine laufende App auf deinem Bildschirm und kannst anfangen, sie nach deinen Wünschen anzupassen.
>
> Alles, was du brauchst, ist ein Mac und ca. eine Stunde Zeit — ein Teil davon ist Wartezeit bei Downloads."

---

## SCHRITT 1: Homebrew installieren (Bildschirmaufnahme)

**Sprechen:**

> "Als erstes installieren wir Homebrew. Homebrew ist ein Paketmanager für den Mac — das bedeutet, er hilft uns, Programme über das Terminal zu installieren, ohne dass wir auf irgendwelche Webseiten gehen und Installer herunterladen müssen.
>
> Öffne dein Terminal. Du findest es über die Spotlight-Suche — drücke Command und Leertaste und tippe Terminal ein."

**Zeigen:** Spotlight öffnen → "Terminal" eingeben → Terminal öffnet sich

**Sprechen:**

> "Jetzt kopiere diesen Befehl und füge ihn ins Terminal ein:"

**Zeigen:** Folgenden Befehl eingeben:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Sprechen:**

> "Das Terminal fragt dich nach deinem Mac-Passwort. Wenn du es eintippst, siehst du keine Zeichen — das ist normal, tippe es einfach blind ein und drücke Enter.
>
> Die Installation dauert ein paar Minuten. Warte, bis du wieder den blinkenden Cursor siehst."

**Zeigen:** Warten bis Installation fertig ist.

**Sprechen:**

> "Wichtig: Am Ende der Installation zeigt dir Homebrew zwei Befehle unter 'Next steps' an. Diese musst du kopieren und ausführen, damit Homebrew richtig funktioniert."

**Zeigen:** Die zwei "Next steps"-Befehle kopieren und ausführen.

**Sprechen:**

> "Um zu prüfen, ob alles geklappt hat, tippe:"

```bash
brew --version
```

**Zeigen:** Versionsnummer wird angezeigt.

---

## SCHRITT 2: Git installieren (Bildschirmaufnahme)

**Sprechen:**

> "Als nächstes installieren wir Git. Git ist ein Tool, mit dem du Code-Projekte herunterladen und verwalten kannst. Auf den meisten Macs ist es schon vorinstalliert. Lass uns prüfen:"

```bash
git --version
```

**Sprechen:**

> "Wenn du eine Versionsnummer siehst, ist Git schon da. Falls nicht, installiere es mit:"

```bash
brew install git
```

---

## SCHRITT 3: Flutter installieren (Bildschirmaufnahme)

**Sprechen:**

> "Jetzt kommt Flutter. Flutter ist das Framework, in dem DynamicLayer gebaut ist. Es ist die Technologie, die deine App auf iOS und Android laufen lässt.
>
> Die Installation ist einfach:"

```bash
brew install flutter
```

**Sprechen:**

> "Das dauert ein paar Minuten. Wenn es fertig ist, führe diesen Befehl aus:"

```bash
flutter doctor
```

**Sprechen:**

> "Flutter Doctor prüft, ob alles richtig installiert ist. Du wirst wahrscheinlich ein paar rote X-Zeichen sehen — das ist okay. Die beheben wir in den nächsten Schritten, wenn wir Xcode und Android Studio installieren.
>
> Wichtig ist, dass bei 'Flutter' ein grüner Haken steht."

**Zeigen:** Ausgabe von `flutter doctor`

---

## SCHRITT 4: Xcode installieren (Kamera + Bildschirmaufnahme)

**Sprechen:**

> "Xcode ist Apples Entwicklungsumgebung. Wir brauchen es, um unsere App im iOS Simulator zu testen — das ist quasi ein virtuelles iPhone auf deinem Mac.
>
> Wichtig: Xcode ist ungefähr 15 Gigabyte groß. Der Download dauert je nach Internetverbindung eine Weile. Starte den Download am besten und mach in der Zwischenzeit eine Pause."

**Zeigen:** Mac App Store öffnen → nach "Xcode" suchen → Installieren klicken

**Sprechen:**

> "Wenn Xcode fertig installiert ist, öffne es einmal und akzeptiere die Lizenzbedingungen. Danach gehen wir zurück ins Terminal und führen diese Befehle aus:"

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

```bash
sudo xcodebuild -runFirstLaunch
```

**Sprechen:**

> "Jetzt installieren wir noch den iOS Simulator:"

```bash
xcodebuild -downloadPlatform iOS
```

**Sprechen:**

> "Das lädt den neuesten iOS Simulator herunter. Danach kannst du prüfen, ob er verfügbar ist:"

```bash
open -a Simulator
```

**Zeigen:** Der iOS Simulator öffnet sich mit einem virtuellen iPhone.

**Sprechen:**

> "Perfekt — du hast jetzt ein virtuelles iPhone auf deinem Mac. Das schließen wir erstmal wieder."

---

## SCHRITT 5: Android Studio installieren (Bildschirmaufnahme)

**Sprechen:**

> "Jetzt installieren wir Android Studio, damit wir unsere App auch auf Android testen können."

```bash
brew install --cask android-studio
```

**Sprechen:**

> "Wenn die Installation fertig ist, öffne Android Studio einmal."

**Zeigen:** Android Studio öffnen → Setup Wizard durchklicken (Standard-Einstellungen beibehalten)

**Sprechen:**

> "Klicke dich durch den Setup Wizard und akzeptiere alle Standardeinstellungen. Android Studio lädt dann automatisch das Android SDK herunter.
>
> Wenn der Setup Wizard fertig ist, müssen wir noch die Android-Lizenzen akzeptieren. Geh zurück ins Terminal:"

```bash
flutter doctor --android-licenses
```

**Sprechen:**

> "Beantworte alle Fragen mit 'y' für yes.
>
> Jetzt richten wir noch einen Android Emulator ein. Öffne Android Studio und klicke auf 'More Actions' und dann 'Virtual Device Manager'."

**Zeigen:** Android Studio → More Actions → Virtual Device Manager → Create Virtual Device → z.B. Pixel 8 auswählen → Neuestes System Image herunterladen → Finish

**Sprechen:**

> "Wähle ein Gerät aus, zum Beispiel das Pixel 8, lade das neueste Android System Image herunter und klicke auf Finish.
>
> Jetzt können wir prüfen, ob alles geklappt hat:"

```bash
flutter doctor
```

**Zeigen:** `flutter doctor` zeigt jetzt grüne Haken bei Flutter, Xcode und Android Studio.

**Sprechen:**

> "Alle grünen Haken da? Perfekt. Damit ist die Basis fertig — dein Mac kann jetzt iOS und Android Apps bauen und testen."

---

## SCHRITT 6: Node.js installieren (Bildschirmaufnahme)

**Sprechen:**

> "Jetzt installieren wir Node.js. Das brauchen wir, damit Claude Code funktioniert. Ganz einfach:"

```bash
brew install node
```

**Sprechen:**

> "Prüfe, ob es geklappt hat:"

```bash
node --version
```

**Zeigen:** Versionsnummer wird angezeigt.

---

## SCHRITT 7: Claude Code installieren (Bildschirmaufnahme)

**Sprechen:**

> "Jetzt kommt Claude Code — das ist das Tool, das für dich den Code schreibt. Du beschreibst, was du willst, und Claude Code setzt es um.
>
> Du brauchst dafür einen Claude Pro oder Max Plan. Falls du noch keinen hast, gehe auf claude.ai und erstelle einen Account."

**Zeigen:** Kurz claude.ai zeigen, Pricing-Seite mit Pro/Max Plan.

**Sprechen:**

> "Wenn du deinen Account hast, installiere Claude Code:"

```bash
npm install -g @anthropic-ai/claude-code
```

**Sprechen:**

> "Um zu prüfen, ob es geklappt hat:"

```bash
claude --version
```

**Zeigen:** Versionsnummer wird angezeigt.

---

## SCHRITT 8: DynamicLayer herunterladen (Bildschirmaufnahme)

**Sprechen:**

> "Jetzt laden wir DynamicLayer herunter. Nach deinem Kauf hast du einen Link zu unserem GitHub Repository bekommen. Wir klonen es jetzt auf deinen Mac.
>
> Zuerst navigieren wir zum Desktop — da legen wir das Projekt ab:"

```bash
cd ~/Desktop
```

**Sprechen:**

> "Jetzt klone das Repository mit dem Link, den du bekommen hast:"

```bash
git clone https://github.com/dynamiclayer/dynamiclayer-pro.git
```

**Sprechen:**

> "Gehe in den Projektordner und lade alle Abhängigkeiten:"

```bash
cd dynamiclayer-pro
```

```bash
flutter pub get
```

**Zeigen:** Flutter lädt die Dependencies herunter.

**Sprechen:**

> "Perfekt — DynamicLayer ist jetzt auf deinem Mac und bereit."

---

## SCHRITT 9: App starten und testen (Bildschirmaufnahme)

**Sprechen:**

> "Jetzt testen wir, ob alles funktioniert. Lass uns die App zuerst im iOS Simulator starten."

### iOS Simulator

```bash
open -a Simulator
```

**Sprechen:**

> "Warte, bis der Simulator hochgefahren ist, und starte dann die App:"

```bash
flutter run
```

**Zeigen:** Die App startet im iOS Simulator. DynamicLayer Komponenten sind sichtbar.

**Sprechen:**

> "Du siehst jetzt die DynamicLayer App mit allen Komponenten und Templates auf deinem virtuellen iPhone. Alles funktioniert.
>
> Jetzt testen wir noch Android. Stoppe die App mit Control + C im Terminal."

### Android Emulator

**Sprechen:**

> "Öffne den Android Emulator. Du kannst die verfügbaren Geräte auflisten mit:"

```bash
flutter emulators
```

```bash
flutter emulators --launch <emulator-name>
```

**Sprechen:**

> "Warte, bis der Emulator hochgefahren ist, und starte dann die App erneut:"

```bash
flutter run
```

**Zeigen:** Die App startet im Android Emulator.

**Sprechen:**

> "Perfekt — dieselbe App läuft jetzt auch auf Android. Damit ist dein Setup komplett."

---

## SCHRITT 10: Claude Code starten und loslegen (Bildschirmaufnahme)

**Sprechen:**

> "Jetzt kommt der spannende Teil. Wir starten Claude Code und passen unsere App an — ohne eine einzige Zeile Code zu schreiben.
>
> Stelle sicher, dass du im Projektordner bist und starte Claude Code:"

```bash
claude
```

**Zeigen:** Claude Code startet im Terminal, Willkommensnachricht erscheint.

**Sprechen:**

> "Claude Code ist jetzt bereit. Du kannst ihm in natürlicher Sprache sagen, was du an deiner App ändern möchtest. Lass uns ein paar Beispiele ausprobieren."

### Beispiel 1: Farbe ändern

**Sprechen:**

> "Sagen wir, du willst die Primärfarbe deiner App ändern:"

**Zeigen:** Eingabe in Claude Code:

```
Ändere die Primary Color zu #FF5500
```

**Sprechen:**

> "Claude Code findet automatisch die richtige Datei, ändert den Farbwert und erklärt dir, was es gemacht hat."

**Zeigen:** Claude Code arbeitet, zeigt die Änderung. Dann:

```bash
flutter run
```

**Zeigen:** App startet mit neuer Farbe.

### Beispiel 2: Text ändern

**Sprechen:**

> "Du willst einen Button-Text ändern? Einfach beschreiben:"

**Zeigen:** Eingabe in Claude Code:

```
Ändere den Button-Text "Sign In" auf der Login-Seite zu "Log In"
```

### Beispiel 3: Komponente hinzufügen

**Sprechen:**

> "Du willst ein neues Element auf einer Seite hinzufügen? Beschreibe es einfach:"

**Zeigen:** Eingabe in Claude Code:

```
Füge auf der Login-Seite unter dem Google-Button einen Separator und einen Button mit dem Text "Continue with Facebook" hinzu
```

**Sprechen:**

> "Claude Code kennt alle DynamicLayer-Komponenten und weiß, wie sie korrekt eingesetzt werden. Du musst nur beschreiben, was du willst."

---

## OUTRO (Kamera)

**Sprechen:**

> "Das war's — dein Setup ist komplett. Du hast jetzt alles auf deinem Mac, um mit DynamicLayer und Claude Code deine eigene App zu bauen.
>
> Nochmal zusammengefasst, was wir installiert haben: Homebrew, Git, Flutter, Xcode mit iOS Simulator, Android Studio mit Android Emulator, Node.js, Claude Code, und DynamicLayer selbst.
>
> Ab jetzt ist dein Workflow ganz einfach:
> 1. Terminal öffnen, in deinen Projektordner gehen
> 2. Claude Code starten
> 3. Beschreiben, was du ändern willst
> 4. Ergebnis im Simulator anschauen
>
> Kein Code lesen, kein Code schreiben — nur beschreiben und sehen.
>
> Wenn du Fragen hast, schreib sie gerne in die Kommentare. Und wenn du DynamicLayer noch nicht hast, findest du den Link in der Beschreibung.
>
> Bis zum nächsten Video!"

---

## Technische Hinweise für die Aufnahme

### Benötigte Aufnahmen
- **Kamera:** Intro, Übergänge zwischen großen Schritten, Outro
- **Bildschirmaufnahme:** Alle Terminal-Befehle, Simulator, Claude Code

### Tipps
- Terminal-Schriftgröße vergrößern (mind. 16pt), damit alles gut lesbar ist
- Bei langen Downloads (Xcode, Android SDK) einen Schnitt machen
- Claude Code Beispiele vorher einmal testen, damit sie im Video flüssig laufen
- Simulator-Fenster groß genug machen, damit die App gut sichtbar ist
