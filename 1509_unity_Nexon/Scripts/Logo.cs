using UnityEngine;
using System.Collections;
using UnityEngine.UI;



public class Logo : MonoBehaviour {



	public GameObject centerEyes;
	public GameObject fillObj;
	public ShowHand showHandControl;
	public GameObject startObj;
	public GameObject canvas;

	private Image fillControl;
	private float fillAmount;
	private Animator anim;

	private bool isActive = false;

	GameObject start1 = null;

	void Start () {
		fillControl = fillObj.GetComponent<Image> ();
		fillControl.fillAmount = 0;

		startObj.transform.localScale = new Vector3 (0, 0, 0);


		anim = GetComponent<Animator> ();
		//anim.speed = 0.1f;
		StartCoroutine (LogoStart (3f));
		

	}

	IEnumerator LogoStart(float waitTime) {
		yield return new WaitForSeconds(waitTime);
		anim.speed = 0.6f;
	}
	
	// Update is called once per frame
	void Update () {

		if (FirstPersonControl.VR) {
			return;
			
		}

		Debug.DrawRay (centerEyes.transform.position, centerEyes.transform.forward*3f, Color.green);

		if (isActive) {
			return;
		}

		fillAmount -= Time.deltaTime;
		if(start1){
			OffColor(start1);
			start1 = null;
		}

		RaycastHit hit;
		if (Physics.Raycast (centerEyes.transform.position, centerEyes.transform.forward, out hit, 100)) {

			if (hit.collider.gameObject.name == "start1") {
				fillAmount += Time.deltaTime * 1.5f;
				start1 = hit.collider.gameObject;
				OnColor(start1);
			}

		}


		fillAmount = Mathf.Clamp01 (fillAmount);
		fillControl.fillAmount = fillAmount;
		
		if (fillAmount == 1f) {
			OffColor(start1);
			FillComplete();

		}

			

	}

	void OnColor(GameObject start){
		start.GetComponent<Renderer>().material.color = new Color32(210, 130, 8, 255);
	}

	void OffColor(GameObject start){
		start.GetComponent<Renderer>().material.color = new Color32(187, 75, 38, 255);
	}


	void FillComplete(){
		Vector3 pos = transform.position + transform.forward;
		LeanTween.move(gameObject, pos, 5.0f) .setEase( LeanTweenType.easeInOutQuart ).setOnComplete(OutComplete);
		//LeanTween.scale(gameObject, new Vector3(0f,0f,0f), 1.0f) .setEase( LeanTweenType.easeOutBack );
		//Destroy(canvas);
		
		isActive = true;
		StartCoroutine (HandActive (3f));
		//showHandControl.Active();
	}

	IEnumerator HandActive(float waitTime) {
		yield return new WaitForSeconds(waitTime);
		showHandControl.Active();
	}

	void OutComplete(){

		Destroy (gameObject);
	}

	void AnimationEnd(){

		LeanTween.scale(startObj, new Vector3(0.6f,0.6f,0.6f), 1.0f) .setEase( LeanTweenType.easeOutBack ).setDelay(0.7f).setOnComplete(AnimationEndComplete);
	}

	void AnimationEndComplete(){
		if (FirstPersonControl.VR) {
			FillComplete();

		}
	}

}
