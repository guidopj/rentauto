DROP SCHEMA IF EXISTS Pers_TP1;
CREATE SCHEMA Pers_TP1;

USE Pers_TP1;

CREATE TABLE Usuarios (
    NOMBRE varchar(45) DEFAULT NULL, 
    APELLIDO varchar(45) DEFAULT NULL,
    NOMBRE_USUARIO varchar(45) NOT NULL,
    EMAIL varchar(45) DEFAULT NULL, 
    FECHA_DE_NAC date DEFAULT NULL,
    VALIDADO tinyint(1) DEFAULT NULL,
    CONTRASENA varchar(45) DEFAULT NULL,
    PRIMARY KEY (NOMBRE_USUARIO)
)

CREATE TABLE Usuarios_Codigo_Validacion (
   NOMBRE_USUARIO varchar(45) NOT NULL,
   CODIGO_VALIDACION varchar(16) NOT NULL,
   PRIMARY KEY (NOMBRE_USUARIO)
)

