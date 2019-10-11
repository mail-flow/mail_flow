json.flows do
  json.array! @flows, partial: 'mail_flow/flows/flow', as: :flow
end
