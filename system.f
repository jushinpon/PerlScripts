      Program main

      Integer input,output 


      open(10, file = 'input.txt')
      open(11, file = 'output.txt')

      read(10,*)input
	output = input+1
      write(11,*)output
      close(10)
      close(11)

      stop
      end