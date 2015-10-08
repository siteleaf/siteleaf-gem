class Time
  def encode_with(coder)
    label =
      if utc?
        usec.zero? ? '%Y-%m-%d %H:%M:%S Z' : '%Y-%m-%d %H:%M:%S.%9N Z'
      else
        usec.zero? ? '%Y-%m-%d %H:%M:%S %:z' : '%Y-%m-%d %H:%M:%S.%9N %:z'
      end

    coder.represent_scalar(nil, strftime(label))
  end
end