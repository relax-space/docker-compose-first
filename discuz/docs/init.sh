#!/bin/sh

if [ $CONFIG_OP = "2" ] || [ $CONFIG_OP = "1"  -a  ! -f "$DISCUZ_ROOT_DIR/web/config/config_global_default.php" ]; then
    cp -r /var/www/html/config/ $DISCUZ_ROOT_DIR\web\config\
fi

/usr/local/bin/apache2-foreground
