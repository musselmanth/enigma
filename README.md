# Enigma Self Assessment - Tom Musselman

## Functionality
>I was able to complete the #crack, #encrypt, #decrypt methods for Enigma as well as command line interfaces for all three.  
The command line interfaces can also take optional arguments so that functionality is similar to the Enigma methods themselves.

## Object Oriented Programming
>I created three other classes for encapsulating the Enigma:
> - **Cryptor:** Handles both encryption and decryption depending on an `action` argument passed to it. The functionality is nearly identical for either action. Cryptor removes character that are not within the character set and passes the remaining characters to the `shifters` for encryption/decryption. After encryption/decryption is complete the Cryptor adds the other characters back in.
> - **Shifter:** Handles the encryption of a single character. Has a factory method called on by the `Cryptor` that generates four instances of Shifter for each of the A, B, C, and D shifters. The shifters either have a negative or positive `@shift` instance variable depending on whether the `Cryptor` is encrypting or decrypting.
> - **Cracker:** Cracker is a child class of `Cryptor`. It functions the same as the `Cryptor` with the `:decrypt` action argument, however during initialization it uses various helper methods to crack the key before passing the key on to the `super` method for `Cryptor#initialize` 

## Ruby Conventions and Mechanics
> - Based on my own judgement the code is formatted correctly and consistently. 
> - I used multiple hashes, the best examples being in the `Cryptor#segregate_characters` and `Cryptor#join_characters` methods. 
> - No methods are longer than 10 lines long.
> - I believe all (or at least most) enumerables are the best tool for the job. There are occasions where `.each` is used, and in each case I believe it was the best tool for the job. There is one method in particular (`Cracker#get_matching_key_segments`) that I would've liked to have found a more efficient way to approach, however it would've added considerable more complexity to the problem.

## Test Driven Development
> - I consistently wrote tests before code, and git history demonstrates that.
> - `Simplecov` shows 100% test coverage.
> - Stubs were used in the `enigma_spec.rb` file to test functions that involved both date or `rand()`.

## Version Control
> - 10 pull requests and 90+ commits (as of writing this)
> - Pull requests are organized based on what is being built or refactored. They include detailed descriptions.
> - The only commits that involve multiple functionalities are ones that involve various minor changes like renaming variables or code reorganization.


