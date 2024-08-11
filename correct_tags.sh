#!/bin/bash

# Step 1: List all tags and process each one
for tag in $(git tag); do
    if [[ $tag == *"beta"* ]]; then
        # Replace 'beta' with 'alpha'
        new_tag=${tag//beta/alpha}
    elif [[ $tag == *"alpha"* ]]; then
	new_tag=$tag
	continue
    else
        # Append '-alpha' to the tag
        new_tag="${tag}-alpha"
    fi
    
    if [[ $tag != $new_tag ]]; then

	# Step 2: Create and push the new tag
	git tag $new_tag $tag
	git push origin $new_tag

	echo "Updated tag: $tag -> $new_tag"
	
	# Delete the old tag locally and remotely
	git tag -d $tag
	git push origin :refs/tags/$tag

	echo "Deleted tag: $tag"	
    else
	echo "Tag $tag did not need to be updated"
    fi

    echo ""
done

echo "Finished"
