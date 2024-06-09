
--------------------------------------------------------
--  Constraints for Table ALBUMES
--------------------------------------------------------

  ALTER TABLE "ALBUMES" ADD CONSTRAINT "PK_Album" PRIMARY KEY ("ID") USING INDEX  ENABLE;
  ALTER TABLE "ALBUMES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "ALBUMES" MODIFY ("TITULO" NOT NULL ENABLE);
  ALTER TABLE "ALBUMES" MODIFY ("ARTISTA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ARTISTAS
--------------------------------------------------------

  ALTER TABLE "ARTISTAS" ADD CONSTRAINT "PK_Artista" PRIMARY KEY ("ID") USING INDEX  ENABLE;
  ALTER TABLE "ARTISTAS" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CANCIONES
--------------------------------------------------------

  ALTER TABLE "CANCIONES" ADD CONSTRAINT "PK_Cancion" PRIMARY KEY ("ID") USING INDEX  ENABLE;
  ALTER TABLE "CANCIONES" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "CANCIONES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "CANCIONES" MODIFY ("MEDIO_ID" NOT NULL ENABLE);
  ALTER TABLE "CANCIONES" MODIFY ("MILISEGUNDOS" NOT NULL ENABLE);
  ALTER TABLE "CANCIONES" MODIFY ("PRECIO_UNITARIO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CANCIONES_EN_LISTA
--------------------------------------------------------

  ALTER TABLE "CANCIONES_EN_LISTA" ADD CONSTRAINT "PK_Canciones_en_lista" PRIMARY KEY ("LISTA_ID", "CANCION_ID") USING INDEX  ENABLE;
  ALTER TABLE "CANCIONES_EN_LISTA" MODIFY ("LISTA_ID" NOT NULL ENABLE);
  ALTER TABLE "CANCIONES_EN_LISTA" MODIFY ("CANCION_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table GENEROS
--------------------------------------------------------

  ALTER TABLE "GENEROS" ADD CONSTRAINT "PK_Genero" PRIMARY KEY ("ID") USING INDEX  ENABLE;
  ALTER TABLE "GENEROS" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LISTAS_DE_REPRODUCCION
--------------------------------------------------------

  ALTER TABLE "LISTAS_DE_REPRODUCCION" ADD CONSTRAINT "PK_Lista" PRIMARY KEY ("ID") USING INDEX  ENABLE;
  ALTER TABLE "LISTAS_DE_REPRODUCCION" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TIPOS_MEDIO
--------------------------------------------------------

  ALTER TABLE "TIPOS_MEDIO" ADD CONSTRAINT "PK_Tipos_medio" PRIMARY KEY ("ID") USING INDEX  ENABLE;
  ALTER TABLE "TIPOS_MEDIO" MODIFY ("ID" NOT NULL ENABLE);


  
--------------------------------------------------------
--  Ref Constraints for Table ALBUMES
--------------------------------------------------------

  ALTER TABLE "ALBUMES" ADD CONSTRAINT "FK_AlbumArtistaId" FOREIGN KEY ("ARTISTA_ID") REFERENCES "ARTISTAS" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CANCIONES
--------------------------------------------------------

  ALTER TABLE "CANCIONES" ADD CONSTRAINT "FK_Album_id" FOREIGN KEY ("ALBUM_ID") REFERENCES "ALBUMES" ("ID") ENABLE;
  ALTER TABLE "CANCIONES" ADD CONSTRAINT "FK_Genero_id" FOREIGN KEY ("GENERO_ID") REFERENCES "GENEROS" ("ID") ENABLE;
  ALTER TABLE "CANCIONES" ADD CONSTRAINT "FK_Medio_id" FOREIGN KEY ("MEDIO_ID") REFERENCES "TIPOS_MEDIO" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CANCIONES_EN_LISTA
--------------------------------------------------------

  ALTER TABLE "CANCIONES_EN_LISTA" ADD CONSTRAINT "FK_Cancion_id" FOREIGN KEY ("CANCION_ID") REFERENCES "CANCIONES" ("ID") DISABLE;
  ALTER TABLE "CANCIONES_EN_LISTA" ADD CONSTRAINT "FK_Lista_id" FOREIGN KEY ("LISTA_ID") REFERENCES "LISTAS_DE_REPRODUCCION" ("ID") ENABLE;

