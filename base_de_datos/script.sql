
CREATE SEQUENCE public.lugares_idlugares_seq;

CREATE TABLE public.Lugares (
                idLugares INTEGER NOT NULL DEFAULT nextval('public.lugares_idlugares_seq'),
                nombre VARCHAR(50) NOT NULL,
                departamento VARCHAR(50) NOT NULL,
                descripcion VARCHAR(200) NOT NULL,
                latitud NUMERIC NOT NULL,
                ubicacion VARCHAR(100),
                provincia VARCHAR(50) NOT NULL,
                longitud NUMERIC NOT NULL,
                municipio VARCHAR(50),
                CONSTRAINT idlugares PRIMARY KEY (idLugares)
);


ALTER SEQUENCE public.lugares_idlugares_seq OWNED BY public.Lugares.idLugares;

CREATE SEQUENCE public.horarios_idhorario_seq;

CREATE TABLE public.Horarios (
                idHorario INTEGER NOT NULL DEFAULT nextval('public.horarios_idhorario_seq'),
                dia VARCHAR(50) NOT NULL,
                hora_inicio TIME NOT NULL,
                hora_fin TIME NOT NULL,
                idLugares INTEGER NOT NULL,
                CONSTRAINT idhorarios PRIMARY KEY (idHorario)
);


ALTER SEQUENCE public.horarios_idhorario_seq OWNED BY public.Horarios.idHorario;

CREATE SEQUENCE public.funcionalidades_idfuncionalidad_seq;

CREATE TABLE public.funcionalidades (
                idFuncionalidad INTEGER NOT NULL DEFAULT nextval('public.funcionalidades_idfuncionalidad_seq'),
                nombre VARCHAR(50),
                CONSTRAINT idfuncionalidad PRIMARY KEY (idFuncionalidad)
);


ALTER SEQUENCE public.funcionalidades_idfuncionalidad_seq OWNED BY public.funcionalidades.idFuncionalidad;

CREATE SEQUENCE public.roles_id_role_seq;

CREATE TABLE public.Roles (
                id_role INTEGER NOT NULL DEFAULT nextval('public.roles_id_role_seq'),
                nombre VARCHAR(100) NOT NULL,
                CONSTRAINT id_rol PRIMARY KEY (id_role)
);


ALTER SEQUENCE public.roles_id_role_seq OWNED BY public.Roles.id_role;

CREATE TABLE public.Privilegios (
                id_role INTEGER NOT NULL,
                idFuncionalidad INTEGER NOT NULL,
                CONSTRAINT privilegios PRIMARY KEY (id_role, idFuncionalidad)
);


CREATE SEQUENCE public.persona_idpersona_seq;

CREATE TABLE public.Persona (
                idPersona INTEGER NOT NULL DEFAULT nextval('public.persona_idpersona_seq'),
                nombres VARCHAR NOT NULL,
                primer_apellido VARCHAR NOT NULL,
                segundo_apellido VARCHAR,
                CI VARCHAR NOT NULL,
                fecha_nacimiento DATE NOT NULL,
                genero VARCHAR(50) NOT NULL,
                direccion VARCHAR(200) NOT NULL,
                CI_complemento VARCHAR,
                email VARCHAR(100),
                celular INTEGER,
                telefono INTEGER,
                CONSTRAINT id PRIMARY KEY (idPersona)
);


ALTER SEQUENCE public.persona_idpersona_seq OWNED BY public.Persona.idPersona;

CREATE TABLE public.Usuarios (
                idPersona INTEGER NOT NULL,
                usuario VARCHAR(50) NOT NULL,
                contrasena VARCHAR(200) NOT NULL,
                rol VARCHAR(50) NOT NULL,
                CONSTRAINT idusuario PRIMARY KEY (idPersona)
);


CREATE UNIQUE INDEX usuarios_idx
 ON public.Usuarios
 ( usuario );

CREATE TABLE public.Favoritos (
                idPersona INTEGER NOT NULL,
                idLugares INTEGER NOT NULL,
                CONSTRAINT idfavoritos PRIMARY KEY (idPersona, idLugares)
);


CREATE SEQUENCE public.comentarios_idcomentario_seq_1;

CREATE TABLE public.Comentarios (
                idComentario INTEGER NOT NULL DEFAULT nextval('public.comentarios_idcomentario_seq_1'),
                comentario VARCHAR(500),
                fecha_comentario DATE NOT NULL,
                rating INTEGER,
                idPersona INTEGER NOT NULL,
                idRecomentario INTEGER NOT NULL,
                CONSTRAINT idcomentario PRIMARY KEY (idComentario)
);


ALTER SEQUENCE public.comentarios_idcomentario_seq_1 OWNED BY public.Comentarios.idComentario;

CREATE SEQUENCE public.fotos_idfotos_seq;

CREATE TABLE public.Fotos (
                idFotos INTEGER NOT NULL DEFAULT nextval('public.fotos_idfotos_seq'),
                descripcion VARCHAR(100),
                url VARCHAR(300) NOT NULL,
                idLugares INTEGER NOT NULL,
                idComentario INTEGER NOT NULL,
                CONSTRAINT idfotos PRIMARY KEY (idFotos)
);


ALTER SEQUENCE public.fotos_idfotos_seq OWNED BY public.Fotos.idFotos;

CREATE TABLE public.Cuenta (
                idPersona INTEGER NOT NULL,
                id_role INTEGER NOT NULL,
                CONSTRAINT idcuenta PRIMARY KEY (idPersona, id_role)
);


ALTER TABLE public.Horarios ADD CONSTRAINT lugares_horarios_fk
FOREIGN KEY (idLugares)
REFERENCES public.Lugares (idLugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fotos ADD CONSTRAINT lugares_fotos_fk
FOREIGN KEY (idLugares)
REFERENCES public.Lugares (idLugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Favoritos ADD CONSTRAINT lugares_favoritos_fk
FOREIGN KEY (idLugares)
REFERENCES public.Lugares (idLugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Privilegios ADD CONSTRAINT funcionalidades_role_funcionalidad_fk
FOREIGN KEY (idFuncionalidad)
REFERENCES public.funcionalidades (idFuncionalidad)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Cuenta ADD CONSTRAINT roles_cuenta_fk
FOREIGN KEY (id_role)
REFERENCES public.Roles (id_role)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Privilegios ADD CONSTRAINT roles_role_funcionalidad_fk
FOREIGN KEY (id_role)
REFERENCES public.Roles (id_role)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Usuarios ADD CONSTRAINT persona_usuarios_fk
FOREIGN KEY (idPersona)
REFERENCES public.Persona (idPersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Cuenta ADD CONSTRAINT usuarios_cuenta_fk
FOREIGN KEY (idPersona)
REFERENCES public.Usuarios (idPersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Comentarios ADD CONSTRAINT usuarios_comentarios_fk
FOREIGN KEY (idPersona)
REFERENCES public.Usuarios (idPersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Favoritos ADD CONSTRAINT usuarios_favoritos_fk
FOREIGN KEY (idPersona)
REFERENCES public.Usuarios (idPersona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fotos ADD CONSTRAINT comentarios_fotos_fk
FOREIGN KEY (idComentario)
REFERENCES public.Comentarios (idComentario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Comentarios ADD CONSTRAINT comentarios_comentarios_fk
FOREIGN KEY (idRecomentario)
REFERENCES public.Comentarios (idComentario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
