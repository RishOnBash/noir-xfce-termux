#!/usr/bin/env bash

# --- INITIALIZE DIRECTORIES ---
THEME_DIR="$HOME/.local/share/themes"
ICON_DIR="$HOME/.local/share/icons"
FONT_DIR="$HOME/.local/share/fonts"
TERM_DIR="$PREFIX/share/xfce4/terminal/colorscheme"
MOUSEPAD_DIR="$HOME/.local/share/gtksourceview-4/styles"
FONT_CONFIG_DIR="$HOME/.config/fontconfig"

mkdir -p "$THEME_DIR" "$ICON_DIR" "$FONT_DIR" "$TERM_DIR" "$MOUSEPAD_DIR" "$FONT_CONFIG_DIR"

# --- INSTALL GRAPHITE-BLACK GTK ---
echo "Installing Graphite-Black GTK Theme..."
git clone --depth=1 https://github.com/vinceliuice/Graphite-gtk-theme.git
cd Graphite-gtk-theme
./install.sh -d "$THEME_DIR" --tweaks black
cd .. && rm -rf Graphite-gtk-theme

# --- INSTALL WHITESUR-GREY ICONS ---
echo "Installing WhiteSur-Grey Icon Pack..."
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh -d "$ICON_DIR" -n WhiteSur-Grey -t grey
cd .. && rm -rf WhiteSur-icon-theme

# --- NOIR TERMINAL THEME ---
echo "Setting up Noir Terminal Theme..."
cat <<EOF > "$TERM_DIR/noir.theme"
[Scheme]
Name=Noir
ColorCursor=#A6A6A6
ColorForeground=#D9D9D9
ColorBackground=#0D0D0D
ColorPalette=#1A1A1A;#4D4D4D;#666666;#808080;#333333;#595959;#999999;#F2F2F2;#262626;#5C5C5C;#7A7A7A;#949494;#474747;#707070;#B3B3B3;#FFFFFF
ColorBold=#FFFFFF
ColorSelection=#262626
ColorSelectionUseDefault=FALSE
EOF

# --- NOIR MOUSEPAD THEME ---
echo "Setting up Noir Theme for Mousepad..."
cat <<EOF > "$MOUSEPAD_DIR/noir.xml"
<?xml version="1.0" encoding="UTF-8"?>
<style-scheme id="noir" _name="Noir" version="1.0">
  <author>RishOnBash</author>
  <_description>Pure monochromatic noir scheme</_description>

  <color name="background"      value="#0D0D0D"/>
  <color name="current-line"    value="#1A1A1A"/>
  <color name="selection"       value="#333333"/>
  <color name="foreground"      value="#D9D9D9"/>
  <color name="comment"         value="#595959"/>
  <color name="white"           value="#FFFFFF"/>
  <color name="dark-grey"       value="#262626"/>
  <color name="mid-grey"        value="#808080"/>
  <color name="light-grey"      value="#B3B3B3"/>
  <color name="bat-accent"      value="#F2F2F2"/>

  <style name="text"                     foreground="foreground" background="background"/>
  <style name="selection"                foreground="white" background="selection"/>
  <style name="cursor"                   foreground="white"/>
  <style name="secondary-cursor"         foreground="light-grey"/>
  <style name="selection-unfocused"      foreground="background" background="mid-grey"/>
  <style name="current-line"             background="current-line"/>
  <style name="line-numbers"             foreground="mid-grey" background="background"/>
  <style name="background-pattern"       background="background"/>
  <style name="bracket-match"            foreground="white" background="dark-grey" bold="true"/>
  <style name="bracket-mismatch"         foreground="white" background="mid-grey"/>
  <style name="search-match"             foreground="background" background="light-grey"/>

  <style name="def:keyword"              foreground="white" bold="true"/>
  <style name="def:statement"            foreground="white"/>
  <style name="def:function"             foreground="bat-accent"/>
  <color name="grey-variant"             value="#A0A0A0"/>
  <style name="def:decimal"              foreground="grey-variant"/>
  <style name="def:preprocessor"         foreground="light-grey"/>
  <style name="def:type"                 foreground="white"/>
  <style name="def:character"            foreground="light-grey"/>
  <style name="def:comment"              foreground="comment"/>
  <style name="def:number"               foreground="grey-variant"/>
  <style name="def:string"               foreground="mid-grey" italic="true"/>
  <style name="def:underlined"           italic="true" underline="true"/>
  <style name="def:note"                 foreground="white" background="background" bold="true"/>
  <style name="def:error"                foreground="white" background="#330000" bold="true"/>
  <style name="def:shebang"              foreground="white" bold="true"/>
  <style name="def:identifier"           foreground="bat-accent" bold="true"/>
  <style name="def:variable"             foreground="light-grey"/>
  <style name="def:boolean"              foreground="white" bold="true"/>
  <style name="def:constant"             foreground="white"/>

  <style name="diff:added-line"          foreground="light-grey"/>
  <style name="diff:removed-line"        foreground="mid-grey"/>
  <style name="diff:changed-line"        foreground="white"/>

  <style name="def:heading"              foreground="white" bold="true"/>
  <style name="def:link-text"            foreground="white" underline="true"/>
  <style name="def:list-marker"          foreground="white" bold="true"/>
  
  <style name="def:heading0" scale="3.0"/>
  <style name="def:heading1" scale="2.5"/>
  <style name="def:heading2" scale="2.0"/>
  <style name="def:heading3" scale="1.7"/>
  <style name="def:heading4" scale="1.5"/>
  <style name="def:heading5" scale="1.3"/>
  <style name="def:heading6" scale="1.2"/>
</style-scheme>
EOF

# --- TERMINUS FONT & TERMINAL CONFIG ---
echo "Installing Terminus Font..."
git clone --depth 1 --filter=blob:none --sparse https://github.com/chrissimpkins/codeface.git ~/codeface-tiny
cd ~/codeface-tiny && git sparse-checkout set fonts/terminus
cp fonts/terminus/*.ttf "$FONT_DIR/"
cd ~ && rm -rf ~/codeface-tiny
fc-cache -fv

echo "Configuring Terminus font..."
cat <<EOF > "$FONT_CONFIG_DIR/fonts.conf"
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="font">
    <test name="family"><string>Terminus</string></test>
    <edit name="antialias" mode="assign"><bool>false</bool></edit>
    <edit name="hinting" mode="assign"><bool>false</bool></edit>
  </match>
</fontconfig>
EOF

# --- APPLYING STYLES AND ICONS ---
echo "Applying Styles and Icons..."
xfconf-query -c xsettings -p /Net/ThemeName -s "Graphite-Black"
xfconf-query -c xsettings -p /Net/IconThemeName -s "WhiteSur-Grey-grey-dark"

# --- SETUP COMPLETE  ---
echo "                                  NOIR SETUP COMPLETE                             "
echo "----------------------------------------------------------------------------------"
echo "STYLES:     Graphite-Black (Theme) & WhiteSur-Grey-grey-dark (Icons) ->> Applied"
echo "FONT:       Settings > Appearance > Fonts > Terminus Medium"
echo "EDITOR:     Mousepad > View > Color Scheme > Noir"
echo "TERMINAL:   Terminal > Edit > Preferences > Colors > Select Preset > Noir"
echo "WALLPAPERS: Check the assets/wallpapers folder"
echo "----------------------------------------------------------------------------------"
exit 0
