def with_feature_active(*features, &block)
  features.each do |feature|
    $rollout.activate(*feature)
  end

  begin
    block.call
  ensure
    features.each do |feature|
      $rollout.deactivate(*feature)
    end
  end
end
