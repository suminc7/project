using UnityEngine;
using System.Collections;
using UnityEngine.Audio;

public class BGM : MonoBehaviour {
	
	public AudioMixer mixer;

	public AudioSource audio1;
	public AudioSource audio1_1;
	public AudioSource audio2;
	public AudioSource audio3;
	public AudioSource audio4;

	void Start () {
		Play1 ();
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void Play1(){
		mixer.SetFloat ("play1", 0);
		mixer.SetFloat ("play1_1", -80);
		mixer.SetFloat ("play2", -80);
		mixer.SetFloat ("play3", -80);
		mixer.SetFloat ("play4", -80);

		audio1.time = 0;
		audio1.Play ();
	}

	public void Play1_1(){
		mixer.SetFloat ("play1", -80);
		mixer.SetFloat ("play1_1", 0);
		mixer.SetFloat ("play2", -80);
		mixer.SetFloat ("play3", -80);
		mixer.SetFloat ("play4", -80);
		
		audio1_1.time = 0;
		audio1_1.Play ();
	}

	public void Play2(){
		mixer.SetFloat ("play1", -80);
		mixer.SetFloat ("play1_1", -80);
		mixer.SetFloat ("play2", 0);
		mixer.SetFloat ("play3", -80);
		mixer.SetFloat ("play4", -80);

		audio2.time = 0;
		audio2.Play ();
	}

	public void Play3(){
		mixer.SetFloat ("play1", -80);
		mixer.SetFloat ("play1_1", -80);
		mixer.SetFloat ("play2", -80);
		mixer.SetFloat ("play3", 10);
		mixer.SetFloat ("play4", -80);

		audio3.time = 0;
		audio3.Play ();
	}

	public void Play4(){
		mixer.SetFloat ("play1", -80);
		mixer.SetFloat ("play1_1", -80);
		mixer.SetFloat ("play2", -80);
		mixer.SetFloat ("play3", -80);
		mixer.SetFloat ("play4", 0);

		audio4.time = 0;
		audio4.Play ();
	}
}
