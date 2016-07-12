module Epitome
	
	def Epitome.wishes(user)
		wishlines = []
		user.own_alternatives.each do |alternative|
			wishlines.push([alternative.name, alternative.evaluations.last.score, alternative.rank])
		end
		
		## this function takes an array (wishlines) as input
		## the elements of this arrray are like ["doctor", 10, 1]
		## the 10 is the mark (on scale 1-10), 
		## while the 1 is its rank (more or less desired as others)
		## the output is also an array, with elements lie ["doctor", 3]
		
		langd = wishlines.length
		
		## Now we order the lines according to rank, no ties are allowed
		lines= wishlines.sort_by { |line| line[2] }
		
		## wished will be an array, its lines consisting of two elements:
		## name is the name of the alternative
		## wished is 1, 2 or 3, 3 being strongly desired, 2 desired, and
		## 1 for not really desired alternatives
		
		wished = []
	
		## lets have a peek of the mark of the first ranked
		## Is it at least 8?
		mark1 = lines[0][1]
		if mark1 > 7
			alternative_desire = [lines[0][0],3]
		else
			## no desired can have a mark under 5
			if mark1 > 5
				alternative_desire = [lines[0][0],2]
			else
				alternative_desire = [lines[0][0],1]
			end
		end
		wished = wished.push(alternative_desire)
		
		## lets have a peek of the mark of the second ranked
		## Is it at least 8 and no first with a 10??
		## but first, let's check if there is more than one alternative...
		if langd < 2
			return wished
		end if
		
		mark2 = lines[1][1]
		if mark2 > 7
			if mark1 < 10
				alternative_desire = [lines[1][0],3]
			else
				alternative_desire = [lines[1][0],2]
			end
		else
			if mark2 > 5
				alternative_desire = [lines[1][0],2]
			else
				alternative_desire = [lines[1][0],1]
			end
		end
		wished = wished.push(alternative_desire)
		
		if langd == 2
			return wished
		end if
		
		## same goes for the one at the third place
		## except that if the mark is smaller than 6, it won't even be medium...
		mark3 = lines[2][1]
		if mark3 > 7
			if mark1 < 10
				alternative_desire = [lines[2][0],3]
			else
				alternative_desire = [lines[2][0],2]
			end
		else
			if mark3 > 5
				alternative_desire = [lines[2][0],2]
			else
				alternative_desire = [lines[2][0],1]
			end
		end
		wished = wished.push(alternative_desire)
		if langd == 3
			return wished
		end
		
		## the rest can not be strongly desired...
		i = 2
		while i < langd - 1
			i += 1
			mark = lines[i][1]
			if mark > 5
				alternative_desire = [lines[i][0],2]
			else
				alternative_desire = [lines[i][0],1]
			end
			wished = wished.push(alternative_desire)
		end
		return wished
	end
	
	def self.test_critical_points(user)
		critical_array = []
		
		user.own_alternatives.each do |alternative|
			critical_array.push([
				alternative.name, 
				alternative.critical_points.proposed_by(user).map { |cp| [cp.point.name, cp.evaluations.last.score] }
			])
		end
		
		return critical_array
	end

	def Epitome.critical_points(user)
		## the intput is an array, each element itself is also a (sub)array.
		## the subarray has the name of the alternative as its first element,
		## and seven lines like ["perseverance", 2] as the other elements (index 
		## 1 to 7)
		## the output is an array, one line per alternative, like ["doctor", 3]
		## (it means the alternative "doctor" is highly desirable
		## considering the critical points belonging to it.)
		
		critical_points_results = []
		
		critical_array = []
		
		user.own_alternatives.each do |alternative|
			critical_array.push([
				alternative.name, 
				alternative.critical_points.proposed_by(user).map { |cp| [cp.point.name, cp.evaluations.last.score] }
			])
		end	
		
		critical_array.each do |this_alternative|
			inner_alternative = this_alternative[1]
			## First, we count +es (3), -es (1) and +-es (2)
			## this_mark can be nil; then it counts as +- (ie default, neutral)
			plusses = 0
			minuses = 0
			zeros = 0

			inner_alternative.each do |inside|
				this_mark = inside[1][2]
				puts "this mark = ", this_mark
				zeros += 1
				if this_mark > 2
					zeros -= 1
					plusses +=1
				end
				if this_mark < 2
					zeros -= 1
					minuses += 1
				end
			end
	
			## Now we have the numbers of +es etc.
			## we can begin to find out how much it is desired (from the mirror seen)
			all_alternatives = []
			critical_result = []
			critical_mark = 1
			if (plusses > 3 && minuses < 2)
				critical_mark = 3
			end
			if (plusses == 3 && minuses == 0)
				critical_mark = 3
			end
			if (plusses == 3 && minuses == 1)
				critical_mark = 2
			end
			if (plusses == 2 && minuses == 0)
				critical_mark = 2
			end	
			puts "plusses = ", plusses
			puts "minuses = ", minuses
			critical_result = [this_alternative[0], critical_mark]
			puts critical_result
			critical_points_results.push(critical_result)
	
			
		end
		return critical_points_results
	
	end
	
	def combine_wishes(x,y)
	## x come from wishes, y from critical points
	## it is just a subroutine, which is not called from the outside of this modul
		if x == 3 && y == 3
			return 3
		end
		if x == 3 && y == 2
			return 3
		end
		if x == 3 && y == 1
			return 2
		end
		if x == 2 && y == 3
			return 2
		end
		if x == 2 && y == 2
			return 2
		end
		return 1
	end
	
	def Epitome.combines_wishes(wisheds, criticals)
	## This combines critical points with wishes, telling how desirable the 
	## alternative really is for the user, all things considering
	## the input is the output from Epitome.wishes and Epitome.critical_points
	## the output is an array of elements like ["doctor", 3] (highly desirable)
	## or ["policeman", 1] if they don't really want to join the police.
	
		combined_wishes = []
		criticals.each do |line|
			critical_mark = line[1]
			wisheds.each do |wishline|
				if wishline[0] == line[0]
					wished_mark = wishline[1]
					combined_mark = combine_wishes(wished_mark, critical_mark)
					combined_wishes.push([line[0], combined_mark])
				end
			end
		end
		return combined_wishes
	end
	
	## so far, the wishes. Now look at the difficulties
	## the procedure is quite like in the desirability round above
	
	def Epitome.difficulties(problem_array)
		## the user have enumerated the requirements per altrernative
		## and noted how well she thinks she can live up to them
		## input: representation is an array, first element is the
		## alternative name, the other elements are arrays themselvs, 
		## consisting of lines such as ["steady hand", 2]
		## again 1 is worst, 3 is best. In the UI, they can be +, - and +-
		## nevertheless, I use the coding 1 to 3 in the program
		## the output is an array, with elements like ["teacher", 2]
		
		
		difficulties_results = []
		langd = problem_array.length
		
		problem_array.each do |this_alternative|
	
			## First, we count +es (3), -es (1) and +-es (2)
			## this_mark can be nil; then it counts as +- (ie default, neutral)
			plusses = 0
			minuses = 0
			zeros = 0
			(1..langd).each do |i|
				this_mark = this_alternative[i][1]
				zeros += 1
				if this_mark > 2
					zeros -= 1
					plusses +=1
				end
				if this_mark < 2
					zeros -= 1
					minuses += 1
				end
			end
	
			## Now we have the numbers of +es etc.
			## we can begin to find out how difficult it is
			## 3 good, 2 bad, 1 awful

			d_result = []
			difficulties_result = []
			d_mark = 2
			if (minuses >= 1)
				d_mark = 1
			else
				if zeros >= 2
					d_mark = 1
				end
			end
			if (minuses == 0 && zeros == 0)
				d_mark = 3
			end
			d_result = [this_alternative[0], d_mark]
			difficulties_results.push(d_result)
		end
		return difficulties_results
	end
	
	## Now for another critical points epitome, this time thinking of difficulties
	## As far as I know, it uses the same marking of critical points as the revious
	
	def Epitome.critical_difficulties(critical_array)
	## this time, starting from the same array as in Epitome.critical_points, 
	## we take the marks as marking difficulties.
	## remark: if in the critical points we had two marks, how desirable and 
	## how difficult, there would be only a slight change and only here, in row 216.
	## the output is again an array, one line per alternative, like ["doctor", 3]
		
		critical_difficulties_results = []
		
		critical_array.each do |this_alternative|
	
			## First, we count +es (3), -es (1) and +-es (2)
			## this_mark can be nil; then it counts as +- (ie default, neutral)
			plusses = 0
			minuses = 0
			zeros = 0
			(1..7).each do |i|
				this_mark = this_alternative[i][1]
				zeros += 1
				if this_mark > 2
					zeros -= 1
					plusses +=1
				end
				if this_mark < 2
					zeros -= 1
					minuses += 1
				end
			end
	
			## Now we have the numbers of +es etc.
			## we can begin to find out how much it is desired (from the mirror seen)
			dificulties_result = []
			difficulties_mark = 2
			if (minuses > 2)
				difficulties_mark = 1
			end
			if (minuses > 1 && zeros >=2)
				difficulties_mark = 1
			end
			if (zeros < 2 && minuses < 2)
				critical_mark = 3
			end
			
			critical_result = [this_alternative[0], critical_mark]
			critical_difficulties_results.push(critical_result)
	
			return critical_difficulties_results
		end
	end
	
	def combine_difficulties(x,y)
	## x come from wishes, y from critical points
		if x == 1 && y == 1
			return 1
		end
		if x == 2 && y == 1
			return 1
		end
		if x == 1 && y == 2
			return 1
		end
		if x == 3 && y == 3
			return 3
		end
		if x == 3 && y == 2
			return 3
		end
		return 2
	end
	
	def Epitome.combines_difficulties(difficulties, criticals)
	## finally, we combine the outputs from Epitome.difficulties and
	## Epitome.critical_difficulties to have a final difficulties array
	## with lines like ["nurse", 2]
		combined_difficulties = []
		criticals.each do |line|
			critical_mark = line[1]
			difficulties.each do |difficulty|
				if difficulty[0] == line[0]
					diff_mark = difficulty[1]
					combined_mark = combine_difficulties(diff_mark, critical_mark)
					combined_difficulties.push([line[0], combined_mark])
				end
			end
		end
		return combined_difficulties
	end
end