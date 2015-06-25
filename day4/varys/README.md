# Varys the mastermind

We are going back to series, and you know that. And more concretely, we are going to explore the marvelous character of Varys,
the Spider, from the Game of Thrones TV show (and obviously, from the Ice and Fire book saga).

Varys is intelligent. He whispers. Not like a snake, but he whispers anyway. He knows secrets, he manages information, and in general
he does a lot of stuff. No wonder he is bald, after all the stress.

Someone, who definitely was not an Ironhack student, tried to compact some abilities that Varys has into a class, but there were two
problems about that implementation. First… it works perfeclty, yeah but THE CODE IS A TOTAL MESS: unreadable, difficult to maintain,
conventionless, and ugly. My eyes bled. Really.

And second… it has no tests! This is a shame, and this Someone made me cry. He made me cry even more than after watching Derek, and
realizing that I will have to wait almost a whole year until next season.

Anyway, we are responsible people and we decide to improve this code. This exercise is composed of two parts:

1. Writing tests that validate the behaviour of all five methods of the Varys class. You should write several tests for the methods
(except for the ones that return a simple String), exploring different parameter possibilities. Think hard!
2. Rewrite and refactor the code so it is way more readable, easier to maintain, and follows the conventions that we have been following
at Ironhack. During the process of refactoring, use the specs in order to know you didn’t break anything.

### Original code

´´´
class Varys
  # Say the name of the character
  def say_my_name!
                "I am Varys, and I'm here to say what you want to hear."
  end

  # Flatter Cersei
  def say_cersei_rocks!
            "Cersei rocks!"
  end





        # Flatter Joffrey
        def say_joffrey_rocks!
             "Joffrey rocks!"
  end

  # Upon receiving a list of words, reverse them and return only the ones
  # which have five letters or more
  def backwards_wording(arg)
    resp = []
          size = arg.size
          i = 0

      while i < size do
        elem = arg[i]

        if elem.length >= 5
          revelem = elem.split(//).reverse.join('')
          resp << revelem
        end

        i+=1
      end

   return resp
end

# Upon receiving a list of float numbers, return a portion of them. If it is
# Friday, return the ones that are below 0. Otherwise, return the ones above
# or equal 0.
def friday_numbers(arg)
        resp = []; i = 0; s = arg.size;

   while i < s do
     e = arg[i]

     if (Time.now.friday? && e < 0) || (!Time.now.friday? && e >= 0)
       resp << e
     end

                 if true
       i+= 1
     end
   end

   return resp
end end
´´