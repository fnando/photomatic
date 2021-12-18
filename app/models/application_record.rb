# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include AttrKeyring.active_record

  def self.inherited(child_class)
    super

    return unless child_class.columns.any? {|col| col.name == "created_at" }

    child_class.implicit_order_column ||= "created_at"
  end
end
