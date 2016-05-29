using UnityEngine;
using System.Collections;

public class LightAnimation : MonoBehaviour {

	// Use this for initialization

	Animator anim;

	void Start () {

		anim = GetComponent<Animator>();

		//StartCoroutine(WaitAndPrint(2F));
	}
	
	IEnumerator WaitAndPrint(float waitTime) {

		yield return new WaitForSeconds(waitTime);

		anim.SetBool ("Small", true);
		

		
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void OnPotal(){
		anim.SetBool ("Small", false);
	}

	public void Ended(){
		//Destroy (gameObject);
		//MovingCubeController MovingCubeControl = GameObject.Find ("MovingCube").GetComponent<MovingCubeController>();
		//MovingCubeControl.Moving ();
	}
}
