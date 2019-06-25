return {
  postgres = {
    up = [[
      DO $$
      BEGIN
        ALTER TABLE IF EXISTS ONLY "upstreams" ADD "algorithm" TEXT;
      EXCEPTION WHEN DUPLICATE_COLUMN THEN
        -- Do nothing, accept existing state
      END;
      $$;

      DO $$
      BEGIN
        ALTER TABLE IF EXISTS ONLY "routes" ADD "headers" JSONB;
      EXCEPTION WHEN DUPLICATE_COLUMN THEN
        -- Do nothing, accept existing state
      END;
      $$;
    ]],
  },

  cassandra = {
    up = [[
      ALTER TABLE upstreams ADD algorithm text;

      ALTER TABLE routes ADD headers map<text,frozen<set<text>>>;
    ]],
  },
}
