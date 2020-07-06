class Gcloud
  GCLOUD_STORAGE_PUBLIC_LINK_ROOT = "https://storage.googleapis.com/"

  attr_reader :datastore

  def initialize
    @datastore = Google::Cloud::Datastore.new(
      project_id: ENV["GOOGLE_CLOUD_PROJECT"],
      credentials: ENV["GOOGLE_APPLICATION_CREDENTIALS"]
    )
  end

  def get_data_entity kind, name

    binding.pry
    debug "get data entity by key \"#{kind} name:#{name}\""

    key = datastore.key [kind, name]
    query = datastore.query(kind).where("__key__", "=", key)

    entities = datastore.run query
  rescue StandardError => e
    debug e.message
    raise e
  end

  def get_child_data_entities kind, parent_key
    # TODO
  end

  def insert_data_entity key, data
    insert_entity_key = datastore.key key
    insert_entity = datastore.entity insert_entity_key

    data.each do |entity_name, value|
      insert_entity[entity_name] = value
      insert_entity.exclude_from_indexes! entity_name, true
    end

    datastore.insert insert_entity
  end

  def upsert_data_entity key, data
    # TODO
  end

  def delete_data_entity key
    # TODO
  end

  private
  def debug message
    prefix = "gcloud log:"
    Rails.logger.debug "#{prefix} - #{message}"
  end
end
