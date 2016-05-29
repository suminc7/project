using UnityEngine;
using System.Collections;

public class ShowHand : MonoBehaviour {

	public HandModel RightHand;
	public HandModel LeftHand;
	public SwordController sword;
	public PopupBox popupBox;
	public GameObject MainPotal;
	public BGM bgm;
	public GameObject centerEyes;
	public EyeCursor eyeCursor;
	public KnightControl hero;

	HandController HandControl;

	private StanControl Stan;
	private Collider CubeStanCd;
	private GameObject indexFinger;
	private GameObject middleFinger;
	private SelectWeponBox weponBox;
	private GameObject currentWeponBox;

	private bool isSelected = false;
	private bool isMoving = false;
	private bool isMiddleHit = false;

	void Start () {
		Stan = GameObject.Find ("stan").GetComponent<StanControl>();
		CubeStanCd = GameObject.Find ("CubeStan").GetComponent<Collider>();
		popupBox.gameObject.SetActive (false);
		sword.gameObject.SetActive (false);
	}
	
	// Update is called once per frame
	void Update () {

		if (FirstPersonControl.VR) {
			return;
		}

		if (!eyeCursor) {
			return;
		}

		if (!isSelected) {



			eyeCursor.Deactive();

			RaycastHit hit;
			if (Physics.Raycast (centerEyes.transform.position, centerEyes.transform.forward, out hit, 100)) {
				
				if (hit.collider.gameObject.tag == "SelectWeponBox") {

					eyeCursor.Active();

					if(weponBox && hit.collider.gameObject != weponBox.gameObject){
						weponBox.DeActiveWepon ();
						eyeCursor.fillAmount = 0f;
					}

					weponBox = hit.collider.gameObject.GetComponent<SelectWeponBox> ();
					weponBox.ActiveWepon();

					if(eyeCursor.fillAmount == 1f){
						hero.HandUp();

						if(eyeCursor.gameObject){
							StartCoroutine(HandUpComplete(1f));
							Destroy(eyeCursor.gameObject);
							eyeCursor = null;
						}

					}

				} 
				
			}


		}

	}

	//after start Text
	public void Active(){
		GetComponent<Collider> ().enabled = true;
		Animator mainPotalAni = MainPotal.GetComponent<Animator> ();
		mainPotalAni.SetBool ("Small", true);

		bgm.Play1_1 ();
	}

	IEnumerator HandUpComplete(float waitTime) {
		
		yield return new WaitForSeconds(waitTime);
		weponBox.SelectWepon ();

	}

	
	void OnTriggerEnter(Collider other) {
		
		if (other.tag == "Player") {
			GetComponent<Collider> ().enabled = false;
			StartCoroutine(StartStan(3F));
		}
		
	}

	IEnumerator StartStan(float waitTime) {
		
		yield return new WaitForSeconds(waitTime);


		Stan.playStartSound();
		StartCoroutine(ActiveHands(4F));//10F
	}


	IEnumerator ActiveHands(float waitTime) {
		
		yield return new WaitForSeconds(waitTime);
		
		Debug.Log("HandActive");

		if (FirstPersonControl.VR) {

		} else {
			HandControl = GameObject.Find ("HeadMountedHandController").GetComponent<HandController> ();
			HandControl.rightGraphicsModel = RightHand;
			HandControl.leftGraphicsModel = LeftHand;
		}


		StartCoroutine(SelectSword(3F));
		
	}

	IEnumerator SelectSword(float waitTime) {
		yield return new WaitForSeconds(waitTime);
		//show select sword popup
		//SelectedSword ();

		popupBox.Active ();
	}

	// run SelectWeponBox.cs
	public void SelectedSword(GameObject wepon) {
		
		isSelected = true;
		//hide popup
		
		FirstPersonControl firstPersonControl = GameObject.Find ("First Person Controller").GetComponent<FirstPersonControl> ();
		firstPersonControl.ActiveSword ();


		if (FirstPersonControl.VR) {
			
		} else {
			HandControl.rightGraphicsModel = null;
			HandControl.leftGraphicsModel = null;
		}

		
		Stan.StartWand ();
		
		Stan.playMovingSound();
		StartCoroutine(Moving(5F));

		sword.gameObject.SetActive (true);
		wepon.transform.parent = sword.transform;

		LeanTween.cancel (wepon);
		LeanTween.scale(wepon, new Vector3(1,1, 1), 3.0f) .setEase( LeanTweenType.easeOutQuad );		
		LeanTween.rotateLocal(wepon, new Vector3(0,180,180), 3.0f) .setEase( LeanTweenType.easeOutQuad );
		LeanTween.moveLocal (wepon, new Vector3 (0, 0, 0), 3.0f) .setEase (LeanTweenType.easeOutQuad);


	}

	public bool GetSelected(){
		return isSelected; 
	}

	public bool GetMoving(){
		return isMoving;
	}


	IEnumerator Moving(float waitTime) {
		
		yield return new WaitForSeconds(waitTime);

		isMoving = true;
		
		FirstPersonControl firstPersonControl = GameObject.Find ("First Person Controller").GetComponent<FirstPersonControl> ();
		firstPersonControl.ActiveSword ();


		CubeStanCd.GetComponent<Collider> ().enabled = true;

		BGM bgm = GameObject.Find ("BGM").GetComponent<BGM> ();
		bgm.Play2 ();

		popupBox.Deactive ();


		
	}



}
