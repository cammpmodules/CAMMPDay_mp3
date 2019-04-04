module MP3
include("AudioDisplay.jl")

using Plots
using FFTW
using WAV

export AB1A1aPlay
export AB1Aufgabe1a
export AB1A1bPlay
export AB1Aufgabe1b
export AB1A1cPlay
export AB1Aufgabe1c
export AB1A1dPlay
export AB1Aufgabe1d
export AB1A2a1Play
export AB1A2a2Play
export AB1Aufgabe2a
export AB1A2bPlay
export AB1Aufgabe2b

function PlaySinusSound(frequency, amplitude, name)
    #Generate and play a sinus sound.
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = amplitude * sin(2*pi*frequency*x[i]);
    end
    #display(y)  
    wavwrite(y, string(name, ".wav"), Fs=44100);
    #y, fs = wavread("SinustonAB1A1a.wav");
    #wavplay(y, fs)
	inline_audioplayer(string(name, ".wav"))
    plot(y)
end


function AB1A1aPlay()
    PlaySinusSound(200, 1, "SinustonAB1A1a")

    # Display 200 Hz sin sound.
    amplitude = 1
    frequenz = 200
	
    x = 0:0.0001:0.1;
    y = zeros(1001);
    for i = 1:1001
        y[i] = amplitude*sin(2*pi*frequenz*x[i]);
    end
    labels = ["Sinuston"];
    plot(x,y, label = labels)
end

function AB1Aufgabe1a(amplitude)
    # Check the amplitude was provided correctly
    if amplitude!=1
        @warn "Amplitude falsch!"
    else
        println("Richtig")
    end
end

function AB1A1bPlay(amplitude)
    PlaySinusSound(200, amplitude, "SinustonAB1A1b")
end

function AB1Aufgabe1b(amplitude)
    if amplitude == 1 
        println("Probier doch auch mal eine andere Amplitude.")
    end
    # Display 200 Hz sin sound.
    frequenz = 200
    
    x = 0:0.0001:0.1;
    y = zeros(1001);
    for i = 1:1001
        y[i] = amplitude*sin(2*pi*frequenz*x[i]);
    end
    labels = ["Sinuston"];
    plot(x,y, label = labels)
end

function AB1A1cPlay(A)
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end 
    #display(ton)
    wavwrite(y, "SinustonAB1A1c1.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A1c1.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A1c1.wav")
end

function AB1Aufgabe1c(A)
    if A(0) != 0
		@warn "Die Amplitude hat zur Zeit t = 0 nicht den Wert 0!"
    end
    m1 = A(1)-A(0);
    m2 = A(2)-A(1);
    if m1 != m2
		@warn "Die Funktion A besitzt kein lineares Wachstum!"
    end
    labels = ["dein Ton"];
    x = 0:0.0001:0.1;
    y = zeros(1001);
    for i = 1:1001
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end
    plot(x,y, label = labels)
end

function AB1A1dPlay(A)
    eps = 1/44100 
    x = range(0.0,stop=1,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1A1d.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A1d.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A1d.wav")
end

function AB1Aufgabe1d(A)
    if A(6) != 0
		@warn "Bei t = 1 hat die Amplitude nicht den Wert 0!"
    end
    m1 = A(1)-A(0);
    m2 = A(2)-A(1);
    if abs(m1 - m2) > 0.0000000001
		@warn "Die Funktion A besitzt kein lineares Abklingverhalten!"
    end
    labels = ["dein Ton"]; 
    x = 0:0.0001:6;
    y = zeros(length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end
    plot(x,y, label = labels)
end

function AB1A2a1Play()
    PlaySinusSound(500, 1, "SinustonAB1A2a")

      # Display 500 Hz sin sound.
      amplitude = 1
      frequenz = 500
      
      x = 0:0.0001:0.1;
      y = zeros(1001);
      for i = 1:1001
          y[i] = amplitude*sin(2*pi*frequenz*x[i]);
      end
      labels = ["Sinuston"];
      plot(x,y, label = labels)
end

function AB1A2a2Play(F_hoeher,F_tiefer)
    eps = 1/44100 
    x = range(0.0,stop=2,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(2*pi*200*x[i]);
    end 
    z = zeros(Float64,length(x));
    for i = 1:length(z)
        z[i] = sin(F_hoeher*2*pi*200*x[i]);
    end
    w = zeros(Float64,length(x));
    for i = 1:length(w)
        w[i] = sin(F_tiefer*2*pi*200*x[i]);
    end
    ton = [y; z; w];
    #display(ton)
    wavwrite(ton, "SinustonAB1A2a.wav", Fs=44100);
    #ton, fs = wavread("SinustonAB1A2a.wav");
    #wavplay(ton, fs)
	inline_audioplayer("SinustonAB1A2a.wav")
end

function AB1Aufgabe2a(F_hoeher,F_tiefer)
    if F_hoeher >= 6 || F_hoeher <= 0
		@warn "F_hoeher liegt nicht zwischen 0 und 6!"
    end
    if F_tiefer >= 6 || F_tiefer <= 0
		@warn "F_tiefer liegt nicht zwischen 0 und 6!"
    end
    if F_hoeher <= 1 
		@warn "Der erste Ton ist nicht höher als der Referenzton!"
    end
    if F_tiefer >= 1
		@warn "Der zweite Ton ist nicht tiefer als der Referenzton!"
    end
    x = 0:0.00001:0.01;
    y = zeros(length(x),3);
    for i = 1:length(x)
        y[i,1] = sin(2*pi*200*x[i]);
        y[i,2] = sin(F_hoeher*2*pi*200*x[i]);
        y[i,3] = sin(F_tiefer*2*pi*200*x[i]);
    end
    labels = ["Referenz" "hoeher" "tiefer"];
    plot(x,y, label = labels)
end

function AB1A2bPlay(F)
    eps = 1/44100 
    x = range(0.0,stop=1,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1A2b.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A2b.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A2b.wav")
end

function AB1Aufgabe2b(F)
    if F(0) != 1
		@warn "Zum Zeitpunkt t = 0 hat die Frequenz von g nicht den Wert 200 Hz!"
    end
    if F(0.1) != 2
		@warn "Zum Zeitpunkt t = 0.1 hat die Frequenz von g nicht den Wert 400Hz!"
    end
    m1 = F(1)-F(0);
    m2 = F(2)-F(1);
    if abs(m1-m2) > 0.00000001
		@warn "Die Funktion F besitzt kein lineares Wachstum!"
    end
    labels = ["dein Signal"];
    x = 0:0.0001:0.1;
    y = zeros(1001);
    for i = 1:1001
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end
    plot(x,y, label = labels)
end

end