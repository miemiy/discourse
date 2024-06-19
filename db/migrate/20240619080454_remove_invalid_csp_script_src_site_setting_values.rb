# frozen_string_literal: true

class RemoveInvalidCspScriptSrcSiteSettingValues < ActiveRecord::Migration[7.0]
  def up
    csp_script_src_setting_value =
      DB.query_single(
        "SELECT value FROM site_settings WHERE name = 'content_security_policy_script_src'",
      ).first

    if csp_script_src_setting_value.present?
      regex =
        %r{
        (?:^'unsafe-eval'$)|
        (?:^'wasm-unsafe-eval'$)|
        (?:^'sha(?:256|384|512)-[A-Za-z0-9+/=]+'$)
      }x
      updated_value =
        csp_script_src_setting_value
          .split("|")
          .select { |substring| substring.match?(regex) }
          .uniq
          .join("|")

      DB.exec(<<~SQL, updated_value:)
        UPDATE site_settings
        SET value = :updated_value
        WHERE name = 'content_security_policy_script_src'
      SQL
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
