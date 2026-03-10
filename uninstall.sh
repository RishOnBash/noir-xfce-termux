# Initialize directories
THEME_DIR="$HOME/.local/share/themes"
ICON_DIR="$HOME/.local/share/icons"
FONT_DIR="$HOME/.local/share/fonts"
TERM_DIR="$PREFIX/share/xfce4/terminal/colorscheme"
MOUSEPAD_DIR="$HOME/.local/share/gtksourceview-4/styles"
FONT_CONFIG_DIR= "$HOME/.config/fontconfig"

# Reverting to standard XFCE defaults (Adwaita)
echo "Restoring default system themes..."
xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita"
xfconf-query -c xsettings -p /Gtk/FontName -s "Sans 10"

# Cleanup files... 
echo "Removing Noir assets..."
rm -rf "$THEME_DIR/Graphite-Black"
rm -rf "$ICON_DIR/WhiteSur-Grey"
rm -f "$FONT_DIR/Terminus"*
rm -f "$MOUSEPAD_DIR/noir.xml"
rm -f "$TERM_DIR/noir.theme"
rm -f "$FONT_CONFIG_DIR/font.conf"

# Unistallation complete
echo "[ INFO ]: Uninstallation complete."
echo "[ INFO ]: Restart your sesssion if changes did not took effect."
