require 'pagy/extras/overflow'

Pagy::DEFAULT[:limit] = 25 # Items per page
Pagy::DEFAULT[:size]  = 9  # How many page links to show

# Handle empty page results
Pagy::DEFAULT[:overflow] = :last_page
