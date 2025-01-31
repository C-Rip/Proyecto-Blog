CREATE DATABASE `blog`;
USE `blog`;

-- Tabla de tipos de usuario
CREATE TABLE `tipousuario` (
  `tipu_id` INT NOT NULL AUTO_INCREMENT,
  `tipu_rol` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`tipu_id`)
);

-- Tabla de usuarios
CREATE TABLE `usuario` (
  `usu_id` INT NOT NULL AUTO_INCREMENT,
  `usu_nombre` VARCHAR(50) NOT NULL,
  `usu_paterno` VARCHAR(50) NOT NULL,
  `usu_materno` VARCHAR(50) NOT NULL,
  `usu_mail` VARCHAR(50) NOT NULL,
  `tipo_usuario_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`usu_id`),
  FOREIGN KEY (`tipo_usuario_id`) REFERENCES `tipousuario` (`tipu_id`)
);

-- Tabla de contenido
CREATE TABLE `contenido` (
  `cont_id` INT NOT NULL AUTO_INCREMENT,
  `cont_titulo` VARCHAR(100) NOT NULL,
  `cont_texto` TEXT NOT NULL,
  `usuario_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`cont_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usu_id`)
);

-- Tabla de calificación
CREATE TABLE `calificacion` (
  `cal_id` INT NOT NULL AUTO_INCREMENT,
  `contenido_id` INT NULL DEFAULT NULL,
  `usuario_id` INT NULL DEFAULT NULL,
  `calificacioncol` INT NOT NULL,
  PRIMARY KEY (`cal_id`),
  UNIQUE (`contenido_id`, `usuario_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usu_id`)
);

-- Tabla de categorías
CREATE TABLE `categoria` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `cat_nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`cat_id`)
);

-- Tabla de comentarios
CREATE TABLE `comentario` (
  `cmt_id` INT NOT NULL AUTO_INCREMENT,
  `cmt_texto` TEXT NOT NULL,
  `cmt_fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `contenido_id` INT NULL DEFAULT NULL,
  `usuario_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`cmt_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usu_id`)
);

-- Tabla intermedia de contenido y categoría
CREATE TABLE `contenido_categoria` (
  `contenido_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`contenido_id`, `categoria_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`cat_id`)
);

-- Tabla de etiquetas
CREATE TABLE `etiqueta` (
  `etiq_id` INT NOT NULL AUTO_INCREMENT,
  `etiq_nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`etiq_id`)
);

-- Tabla intermedia de contenido y etiqueta
CREATE TABLE `contenido_etiqueta` (
  `contenido_id` INT NOT NULL,
  `etiqueta_id` INT NOT NULL,
  PRIMARY KEY (`contenido_id`, `etiqueta_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`),
  FOREIGN KEY (`etiqueta_id`) REFERENCES `etiqueta` (`etiq_id`)
);

-- Tabla de imágenes
CREATE TABLE `imagen` (
  `img_id` INT NOT NULL AUTO_INCREMENT,
  `img_url` VARCHAR(100) NOT NULL,
  `contenido_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`img_id`),
  FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`cont_id`)
);
