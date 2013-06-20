if defined?(ActiveModel)
  class UniquenessValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless options[:solr_name].present? 
        raise ArgumentError, "UniquenessValidator was not passed :solr_name. Example: validates :uniqueness => { :solr_name => 'name_t' }"
      end

      if ! value.empty? 
        if ! record.persisted? && record.class.where( options[:solr_name] => value ).limit(1).to_a.count > 0
          record.errors.add attribute, :taken, value: value
        end
      end
    end
  end
end