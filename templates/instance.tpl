
  INSTANCE_NAME:
    build:
      context: ./build-php
      ulimits:
        nofile:
          soft: 65536
          hard: 65536   
    ports:
      - "INSTANCE_PORT:80"  
    volumes:
      - $HOME/php-mysql-datas/html/INSTANCE_NAME:/var/www/html
    volumes_from:
      - mysql56-datas
    networks:
      - php-mysql    
    depends_on:
      - mysql56-datas
