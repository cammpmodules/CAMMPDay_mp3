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

function AB1ZAPlay(A,a,b)
    eps = 1/44100 
    a_ton = a - 1;
    b_ton = b + 1;
    x = range(a_ton,stop=b_ton,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1A2b.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1A2b.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1A2b.wav")
end

function AB1ZusatzaufgabeA(A4,t_min,a,b)
    if t_min <= a || t_min >= b
		@warn " t_min liegt nicht zwischen a und b!"
    end
    min = 1;
    for i = -10:10
        if A4(t_min + i/100) < A4(t_min)
            min = 0;
        end
    end
    if min == 0
		@warn "Bei t = t_min ist die Amplitude nicht minimal!"
    end
    labels = ["dein Ton"];
    if t_min > a && t_min < b 
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = A4(x[i])*sin(2*pi*200*x[i]);
        end
        plot(x,y, label = labels)
    end
end

function AB1ZBPlay(A,a,b)
    eps = 1/44100 
    x = range(a,stop=b,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = A(x[i])*sin(2*pi*50*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1ZB.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1ZB.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1ZB.wav")
end
  
function AB1ZusatzaufgabeB(A5,t_max,a,b)
    if t_max <= a || t_max >= b
		@warn "t_max liegt nicht zwischen a und b!"
    end
    if A5(a) != 0 
		@warn "Bei t = a hat die Amplitude nicht den Wert 0!"
    end
    if A5(b) != 0
		@warn "Bei t = b hat die Amplitude nicht den Wert 0!"
    end
    max = 1;
    for i = -10:10
        if A5(t_max + i/100) > A5(t_max)
            max = 0;
        end
    end
    if max == 0
		@warn "Bei t = t_max ist die Amplitude nicht maximal!"
    end
    labels = ["dein Ton"];
    if t_max > a && t_max < b 
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = A5(x[i])*sin(2*pi*50x[i]);
        end
        plot(x,y, label = labels)
    end
end

function AB1ZCPlay(a,F)
    eps = 1/44100
    b = a + 1;
    x = range(a,stop=b,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1ZC.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1ZC.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1ZC.wav")
end
    

function AB1ZusatzaufgabeC(a,b,F)
    if b <= a 
		@warn "b muss größer sein als a!"
    end
    increase = 1;
    for i = 1:100
        if F(a+(b-a)/100*i) < F(a+(b-a)/100*(i+1))
            increase = 0;
        end
    end
    if increase == 0
		@warn "Die Frequenz fällt nicht auf dem Intervall [a,b]!"
    end
    labels = ["dein Signal"];
    if a < b
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = sin(F(x[i])*2*pi*200*x[i]);
        end
        plot(x,y, label = labels)
    end
end

function AB1ZDPlay(a,b,F)
    eps = 1/44100
    x = range(a,stop=b,step=eps);
    y = zeros(Float64,length(x));
    for i = 1:length(y)
        y[i] = sin(F(x[i])*2*pi*200*x[i]);
    end 
    #display(y)
    wavwrite(y, "SinustonAB1ZD.wav", Fs=44100);
    #y, fs = wavread("SinustonAB1ZD.wav");
    #wavplay(y, fs)
	inline_audioplayer("SinustonAB1ZD.wav")
end
    
function AB1ZusatzaufgabeD(a,b,F)
    if b <= a
		@warn "b muss größer sein als a!"
    end
    labels = ["dein Signal"];
    if a < b
        x = a:(b-a)/10000:b;
        y = zeros(length(x));
        for i = 1:length(y)
            y[i] = sin(F(x[i])*2*pi*200*x[i]);
        end
        plot(x,y, label = labels)
    end
end


end