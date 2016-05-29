using UnityEngine;
using System.Collections;

public class FirstPersonControl : MonoBehaviour {

	public static bool VR = false;

	public GameObject leapOVR;
	public GameObject centerEye;
	///private GameObject knight;

	public AudioClip potalSound;
	public AudioClip attackSound;
	public ShowHand showHand;
	public GameObject knight;

	private GameObject movingCube;
	//private GameObject Player;
	private KnightControl knightControl;
	private MovingCubeController movingController;
	private CharacterController CharacterControl;
	private AudioSource audio;
	private GameObject KnightContainer;

	Vector3 currentPos;
	Transform lookAtPos;
	private GameObject handContainer;

	Animation currentAni;
	int frameCount = 0;

	bool isSword = false;
	

	float hx = 0f;
	float hy = 0f;
	float maxX = 10000f;
	float maxY = 0f;
	// Use this for initialization
	void Start () {




		currentAni = GetComponent<Animation> ();

		CharacterControl = GetComponent<CharacterController> ();
		KnightContainer = GameObject.Find ("KnightContainer");
		knightControl = knight.GetComponent<KnightControl>();
		//Player = GameObject.Find ("Player");
		movingCube = GameObject.Find ("MovingCube");
		movingController = movingCube.GetComponent<MovingCubeController>();
		audio = GetComponent<AudioSource> ();

		//knight = knightControl.gameObject;

		lookAtPos = movingController.transform;
		currentPos = transform.position;


		if (FirstPersonControl.VR) {
			Vector3 vec3 = knight.transform.localPosition;
			vec3.z = 0;
			knight.transform.localPosition = vec3;
		}
	}
	


	void Update () {

		//Debug.Log (frameCount);
		//frameCount++;

		MoveToCube ();
		RotateAndForward ();

		if (showHand.GetMoving ()) {
			Attack ();
		}

	}

	void RotateAndForward(){
		Quaternion lookPos = centerEye.transform.rotation;
		lookPos.x = 0;
		lookPos.z = 0;
		KnightContainer.transform.rotation = lookPos;
		
		
		float speed = 3.0f;
		float smooth = 1.0f - Mathf.Pow(0.5f, Time.deltaTime * speed);
		transform.forward = Vector3.Lerp(transform.forward, movingCube.transform.forward, smooth);
	}


	void Attack(){

		//GameObject handContainer = GameObject.Find ("PepperLightFullRightHand(Clone)/HandContainer") as GameObject;
		handContainer = GameObject.Find ("RigidRoundHand(Clone)/forearm") as GameObject;
		//palm,forearm
		
		if (handContainer) {


			hx = handContainer.transform.position.x;
			hy = handContainer.transform.position.y;
			
			//maxX = Mathf.Min(maxX, hx);
			maxY = Mathf.Max(maxY, hy);



			if (maxY - hy < 0.1f && maxY - hy > 0.05f) {
				//Debug.Log(maxY - hy);
				knightControl.Attack(0);
				maxY = hy;
			}


		} else {

			maxX = 10000f;
			maxY = 0f;
		}

	}

	void MoveToCube(){
		
		Vector3 customPos = lookAtPos.position;
		customPos.y = transform.position.y;
		
		float step = 2.8f * Time.deltaTime;
		transform.position = Vector3.MoveTowards(transform.position, customPos, step);
		
		
		float dist = Vector3.Distance (transform.position, customPos);
		if (dist > 0.1f) {
			knightControl.OnWalking ();
		} else {
			knightControl.OffWalking();
		}
	}

	public void AttackVR(){
		knightControl.Attack(0);
	}

	void OnTriggerEnter(Collider other) {

		if (other.tag == "Cube") {
			movingController.Moving();
		}

	}

	/*
	 * public
	 */
	public void ActiveSword(){
		isSword = true;
	}

	//Potal.cs
	public void MoveToPotal(GameObject potal){

		Vector3 pos = potal.transform.position;
		transform.position = pos;
		transform.forward = potal.transform.forward;

		audio.PlayOneShot (potalSound);

	}

	public void PlayAttackSound(){
		audio.PlayOneShot (attackSound);
	}





}
