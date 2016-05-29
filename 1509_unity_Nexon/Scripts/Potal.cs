using UnityEngine;
using System.Collections;

public class Potal : MonoBehaviour {

	Animator anim;
	Animator anim2;
	FirstPersonControl Player;
	MovingCubeController MovingCubeControl;

	public GameObject NextPotal;

	void Start () {
		anim = transform.GetChild(0).gameObject.GetComponent<Animator>();
		anim2 = NextPotal.transform.GetChild(0).gameObject.GetComponent<Animator>();

		MovingCubeControl = GameObject.Find("MovingCube").GetComponent<MovingCubeController>();

	}
	
	// Update is called once per frame
	void Update () {
	
	}


	void OnTriggerEnter(Collider other) {

		if (other.tag == "Player") {
			Player = other.gameObject.GetComponent<FirstPersonControl>();
			anim.SetBool("on", true);
			anim2.SetBool("on", true);
		}
		
	}


	/*
	 * animation Event
	 */
	public void OnPotal(){
		anim.SetBool("on", false);
		anim2.SetBool("on", false);


		Player.MoveToPotal (NextPotal);
		MovingCubeControl.Moving();

		StartCoroutine(PotalComplete(3F));
	}
	
	IEnumerator PotalComplete(float waitTime) {
		yield return new WaitForSeconds(waitTime);
		MovingCubeControl.Moving();
	}


}
