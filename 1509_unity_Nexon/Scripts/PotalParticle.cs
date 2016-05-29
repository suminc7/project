using UnityEngine;
using System.Collections;

public class PotalParticle : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnPotal(){
		Potal potal = transform.parent.GetComponent<Potal> ();
		if (potal) {
			potal.OnPotal ();
		}

	}

}
