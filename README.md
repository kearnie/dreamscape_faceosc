# dreamscape_faceosc
dreamscape interaction with facial recognition

project demo video: https://vimeo.com/187479682

Rather than experimenting with a concept that was instinctively face-controlled, such as objects inherently representing faces, 
or masks/robots/other images, I wanted to explore something more abstract and relatable to my own aesthetics: that translated into 
more introspective, tranquil, and atmospheric ideas on which I base a lot of my interactive works. I almost automatically thought 
of skies/seas, gearing towards the starry path of galaxies and stardust in which someone can lose him or herself.

As such came the daydreaming concept of my project, being reliant on the openness of one’s eyes; I would allow a dreamscape of 
night stars light specks to fade in if the user’s eyes are closed or lower than/default. However, if the user is to open his or 
her eyes wider to a noticeable threshold, the dreamscape would snap back to a blank reality abruptly, as if one were suddenly 
woken up from a daydream by a third party. I also wanted to toy with the juxtaposition of having visuals that one ironically 
wouldn’t be able to see if his or her eye’s were opened (haha)–afterwards I just changed this to a daydream, rather than actual 
sleeping/eyes had to be fully closed, concept–for practical reasons; I also feel like this didn’t stray too far from my intrinsic 
intentions of “being” in another world.

The visuals this time hinged on the atmosphere of the dreamscape, dealt with through gradients, flickering/fading opacities, 
and the subtle movements of a new particle class that I learned. Rather than having a blank template or default face, I thought 
to translate the daydream aspect abstractly to the “awake” portion as well. At the default, “awake” phase of the simulation, 
I removed the traces of an avatar and instead designated two particle bursts of where the eyes would be–these minor explosions 
follow the user’s eyes and represent how the stardust from the dreamscape realm is almost itching to come to fruition, to burst 
out–indicating how difficult it is for someone to perhaps not daydream usually. Once someone blanks out or loses focus, or in 
this case lessen the openness of eyes, the dreamscape reappears and the stardust particles float effortlessly and arbitrarily 
throughout the screen. When the simulation is first run, the stardust of the dreamscape expand from a cluster in the middle, 
otherwise abstracted as the center of the user’s mind, and travel outwards to the boundaries, giving a sense of the user moving 
forward and falling deeper, traveling further into the dream; the dreamscape is otherwise decorated by flickering stars and a 
fading night gradient.

I also wanted to advance the dreamscape with calming, therapeutic music, and I did so by utilizing the Processing audio capabilities, 
modifying the amp() to be higher when the eyes are smaller/dreamscape is occurring, and the amp() be 0 and for the music to stop 
abruptly if the eyes were open/avatar was in “reality”. The audio I selected is the soundtrack Will of the Heart from the animated 
show Bleach.

Hence I wanted this to be a sort of introspective interaction between the person and him or herself: that people are fighting 
their own concentration and awareness to not accidentally fade in to a daydream–or perhaps purposely daydream and enjoy the experience. 
Other than that, it is an interaction between the user and the interface, to enjoy the visuals of an abstract, idyllic, 
and atmospheric setting.

**personal notes with troubleshooting/my own laptop in particular: I think it’s because my laptop is of a newer model with Windows, 
so its screen resolution is supposedly “crazy high”–that being, a lot of my software windows (i.e. Processing, Photoshop, CamStudio, 
OBS, etc.) turn up tiny because of their inherently smaller windows resolutions… as such when I run the Processing code, the output 
windows is just a small square 🙁 It’s unfortunate that I feel like the size takes away from fully being immersed in the visuals 
but it can’t be helped–I’ve checked online for problem-solving, and this has actually been tagged as a “high-priority” problem in 
Processing’s open-source GitHub forum, but no solution has been provided yet.. this project, especially when it got to the 
screengrab/video-recording portion, also really made me wish I had a Mac/used OSX haha.. finding a software to properly record 
the screen was hard–and then working with the software’s windows to properly click the Play/Stop button on my “high-res” laptop 
was even harder because–surprise–the windows for the software were tiny too. And then the outputted files were huge. 
(my first attempt outputted a file of 4.0 GB…) but–I just wanted to record some benchmarks for personal’s sake. 
This was quite a journey–and in the end I’m thankful I got what I needed to get done, done.
