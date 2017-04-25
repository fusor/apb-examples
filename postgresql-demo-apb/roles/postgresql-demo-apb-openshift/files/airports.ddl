CREATE TABLE airports
(
  name character varying(256),
  code character varying(256) NOT NULL,
  passengers int,
  the_geom geometry(Geometry,4326),
  CONSTRAINT airports_pk PRIMARY KEY (code )
)
WITH (
  OIDS=FALSE
);

CREATE INDEX geom_index_airports
  ON airports
  USING gist
  (the_geom );
