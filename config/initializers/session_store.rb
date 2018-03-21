Nextbooks::Application.config.session_store :redis_store, {
  servers: [
    {
      host: ENV["REDIS_HOST"],
      port: ENV["REDIS_PORT"],
      db: 0,
      namespace: "session"
    },
  ],
  expire_after: 1.week, 
  key: "_#{Rails.application.class.parent_name.downcase}_session"
}
