return function(entity)
    if entity.active_sprite then
    entity.active_sprite:draw(entity.image, entity.body:getX(), entity.body:getY(), entity.body:getAngle())
    love.graphics.setColor(160, 72, 14, 255)
    love.graphics.polygon('line', entity.body:getWorldPoints(entity.shape:getPoints()))
    love.graphics.setColor(255, 255, 255, 255)
  end
end
