use Croma

defmodule StackoverflowCloneA.Dodai do
  app_id   = "a_BvqzN73e"
  group_id = "g_HtEsAbX7"

  use AntikytheraAcs.Dodai.GearModule,
    app_id:                app_id,
    default_group_id:      group_id,
    default_client_config: %{recv_timeout: 10_000}

  def app_key(),  do: StackoverflowCloneA.get_env("app_key")
  def root_key(), do: StackoverflowCloneA.get_env("root_key")
end
