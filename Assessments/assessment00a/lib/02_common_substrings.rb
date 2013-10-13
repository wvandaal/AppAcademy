def common_substrings(str1, str2)
  	lcs = ""
  	start_ind = 0

  	while start_ind < str1.length - 1
    	len = 1
    	while (start_ind + len) <= str1.length
      		if len < lcs.length
        		len += 1
        		next
      		end
      		end_ind = start_ind + len
      		str = str1[start_ind..end_ind]
      		lcs = str if str2.include?(str)
      		len += 1
    	end
    	start_ind += 1
  	end
  	lcs
end