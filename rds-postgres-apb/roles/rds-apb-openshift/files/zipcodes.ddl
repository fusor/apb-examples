CREATE TABLE zipcodes
(
  zipcode CHARACTER(5) NOT NULL,
  city character varying(256),
  state character varying(256),
  count INTEGER,
  the_geom geometry(Geometry,4326),
  CONSTRAINT zipcodes_pk PRIMARY KEY (zipcode )
)
WITH (
  OIDS=FALSE
);

CREATE INDEX geom_index_zipcodes
  ON zipcodes
  USING gist
  (the_geom );
