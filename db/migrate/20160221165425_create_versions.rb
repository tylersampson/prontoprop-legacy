class CreateVersions < ActiveRecord::Migration

  # Class names of MySQL adapters.
  # - `MysqlAdapter` - Used by gems: `mysql`, `activerecord-jdbcmysql-adapter`.
  # - `Mysql2Adapter` - Used by `mysql2` gem.
  MYSQL_ADAPTERS = [
    "ActiveRecord::ConnectionAdapters::MysqlAdapter",
    "ActiveRecord::ConnectionAdapters::Mysql2Adapter"
  ]

  # The largest text column available in all supported RDBMS is
  # 1024^3 - 1 bytes, roughly one gibibyte.  We specify a size
  # so that MySQL will use `longtext` instead of `text`.  Otherwise,
  # when serializing very large objects, `text` might not be big enough.
  TEXT_BYTES = 1_073_741_823

  def change
    create_table :versions, versions_table_options do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object,    :limit => TEXT_BYTES

      # Known issue in MySQL: fractional second precision
      # -------------------------------------------------
      #
      # MySQL timestamp columns do not support fractional seconds unless
      # defined with "fractional seconds precision". MySQL users should manually
      # add fractional seconds precision to this migration, specifically, to
      # the `created_at` column.
      # (https://dev.mysql.com/doc/refman/5.6/en/fractional-seconds.html)
      #
      # MySQL users should also upgrade to rails 4.2, which is the first
      # version of ActiveRecord with support for fractional seconds in MySQL.
      # (https://github.com/rails/rails/pull/14359)
      #
      t.datetime :created_at
    end
    add_index :versions, [:item_type, :item_id]
  end

  private

  # Even modern versions of MySQL still use `latin1` as the default character
  # encoding. Many users are not aware of this, and run into trouble when they
  # try to use PaperTrail in apps that otherwise tend to use UTF-8. Postgres, by
  # comparison, uses UTF-8 except in the unusual case where the OS is configured
  # with a custom locale.
  #
  # - https://dev.mysql.com/doc/refman/5.7/en/charset-applications.html
  # - http://www.postgresql.org/docs/9.4/static/multibyte.html
  #
  # Furthermore, MySQL's original implementation of UTF-8 was flawed, and had
  # to be fixed later by introducing a new charset, `utf8mb4`.
  #
  # - https://mathiasbynens.be/notes/mysql-utf8mb4
  # - https://dev.mysql.com/doc/refman/5.5/en/charset-unicode-utf8mb4.html
  #
  def versions_table_options
    if MYSQL_ADAPTERS.include?(connection.class.name)
      { options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_col' }
    else
      {}
    end
  end
end