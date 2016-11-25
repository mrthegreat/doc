exec { 'php_xml':
    command => '/usr/bin/apt-get install php-xml -y'
  }

exec { 'install_drush':
    command => '/usr/bin/sudo /usr/bin/php -r "readfile(\'https://s3.amazonaws.com/files.drush.org/drush.phar\');" > /usr/local/bin/drush'
}

exec { 'give_run_rights':
    command => '/usr/bin/sudo chmod +x /usr/local/bin/drush',
    require => Exec['install_drush']
}

exec { 'install_php_mysql':
        command => '/usr/bin/apt install php-mysql -y'
}

exec { 'install_php_gd':
        command => '/usr/bin/apt install php-gd -y'
}

exec { 'create_example_proj':
        command => '/usr/bin/sudo drush dl drupal --drupal-project-rename=example --yes',
        cwd => '/home/ubuntu/',
        require => Exec['give_run_rights']
}

exec { 'install_drupal':
        command => '/usr/local/bin/drush site-install standard --db-url=\'mysql://drupal:password@localhost/drupal\' --site-name=Example --yes',
        cwd => '/home/ubuntu/example',
        require => Exec['create_example_proj']
}

exec { 'move_drupal':
        command => '/bin/mv example/ /var/www/html/',
        cwd => '/home/ubuntu/',
        require => Exec['install_drupal']
}

exec { 'configure_drupal':
        command => '/bin/cp /root/.htaccess /var/www/html/example/',
        require => Exec['move_drupal']
}

exec { 'configure_apache':
        command => '/bin/cp /root/apache2.conf /etc/apache2/apache2.conf',
        require => Exec['configure_drupal']
}

exec {'enable_rewrite':
        command => '/usr/sbin/a2enmod rewrite',
        require => Exec['configure_apache']
}

exec {'set_ownership':
    command => '/bin/chown -R www-data:www-data /var/www/html/example',
    require => Exec['enable_rewrite']
}

exec {'clear_drupal_cache':
        command => '/usr/local/bin/drush cr',
        cwd => '/var/www/html/example/',
        require => Exec['set_ownership']
}

exec {'apache_restart': 
	command => '/usr/sbin/service apache2 restart',
	require => Exec['clear_drupal_cache']
}
