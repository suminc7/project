using UnityEngine;
using System.Collections;

public class Finished : MonoBehaviour {

	public KnightControl hero;

	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnTriggerEnter(Collider other) {
		
		if (other.tag == "Player") {

		
			StanControl Stan = GameObject.Find ("stan").GetComponent<StanControl>();
			Stan.playEndSound();

			hero.HandDown();

		}
		
	}

	public void SetActive(){
		GetComponent<Collider> ().enabled = true;
	}
}
