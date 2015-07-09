def do_the_job(job)
  last_msg = nil
  job.stream do |s|
    if (msg = s['message']) && (msg != last_msg)
      puts msg
      last_msg = msg
    end
  end
end

def publish(site_id, quiet = true)
  site = Siteleaf::Site.new(id: site_id)
  job = site.publish
  if quiet
    puts '=> Publish queued.\n'
  else
    do_the_job(job)
    puts '=> Publish completed.\n'
  end
end
