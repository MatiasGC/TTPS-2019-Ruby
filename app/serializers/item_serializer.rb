class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :estado, :valor_venta
end
